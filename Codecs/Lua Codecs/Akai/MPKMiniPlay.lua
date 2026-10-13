--[[
	MPK Mini Play — Reason Remote codec
	====================================

	Author:   Kester
	Project:  akai-mpk-mini-play-reason-remote
	Reason:   Reason 10+ any version running the Lua Remote SDK.
	Device:   Akai MPK Mini Play

	Description
	-----------
	Two-way Remote codec for the Akai MPK Mini Play. Provides the control
	surface items consumed by the .remotemap files in Maps/Akai/.

	MIDI assignment table (hardware layout, verified by live capture):

		Item          Physical control          MIDI
		----------    ------------------------   ----------------
		Keyboard      Keyboard (25 keys)         notes 48-72 on ch1
		Pad 1..8      Pad Bank A (1-8)           notes 16-23 on ch1
		Pad 9..16     Pad Bank B (1-8)           notes 32-39 on ch1
		Knob 1 A..4 A Knobs 1-4 (Bank A)         CC48-51 on ch1
		Knob 1 B..4 B Knobs 1-4 (Bank B)         CC64-67 on ch1
		Joystick X    Joystick, X axis           Pitch Bend on ch1
		Joystick Y    Joystick, Y axis           CC16 on ch1

	Notes
	-----
	- The MPK Mini Play has NO transport buttons and NO sustain pedal.
	  (Transport = false in mapping/mpk-mini-play-controls.json.)
	- Everything transmits on MIDI channel 1. The pads use fixed note numbers
	  16-23 (Bank A) and 32-39 (Bank B); the keybed occupies notes 48-72, so
	  the two note ranges never overlap.
	- The pads behave as a classic drum-pad bank. Reason's drum devices (Kong,
	  Redrum) trigger their pads/drums from notes 36-51 (C1-D#2), so
	  remote_process_midi() transposes the incoming pad notes into that range
	  and re-emits them as Keyboard notes (item 1). The raw pad note is
	  consumed so it never reaches the Keyboard auto-inputs; only keybed notes
	  (48-72) reach those auto-inputs untouched. Pad Bank A -> Kong/Redrum
	  pads 1-8, Pad Bank B -> pads 9-16.
	- Each pad press is ALSO emitted as its matching Pad 1..16 control-surface
	  item, so a .remotemap may bind pads per device (e.g. the Dr. Octo Rex
	  scope maps Bank A -> Select Loop 1-8 and Bank B pad 1 -> Run; the Drum
	  Sequencer scope maps the single Pattern item (driven by Bank A pads)
	  -> Pattern Select and Bank B pads 1-3 -> On / Record / Play). Devices
	  that do not map those items ignore them,
	  so the drum-note behaviour is preserved for Kong and Redrum.
	- The knob Bank A/B switch does not change the CC numbers of the four
	  physical knobs beyond their two fixed assignments (CC48-51 for Bank A,
	  CC64-67 for Bank B).
	- Knobs control parameters directly (no soft takeover / pickup): the
	  first movement of a knob is applied immediately, so there is no need
	  to sweep past a value first. See remote_process_midi().
	- No remote_probe is supplied: the MPK Mini Play does not answer the
	  Universal SysEx Identity Request reliably, so add the controller
	  manually in Reason > Preferences > Control Surfaces (Auto-Detect will
	  not find it). A stub is commented out at the bottom for reference.
]]

--------------------------------------------------------------------------
-- Knob (analog) item layout
--------------------------------------------------------------------------
-- The 8 knob items are at positions gFirstAnalogIndex ..
-- gFirstAnalogIndex + gNumberOfAnalogs - 1 in the items table below
-- (Keyboard, _Scope, Pad 1..16 come first, so the first knob is index 19).
gFirstAnalogIndex = 19
gNumberOfAnalogs = 8

-- Item indices: 1 = Keyboard, 2 = _Scope, 3..18 = Pad 1..16. Pads are driven
-- from MIDI in remote_process_midi() (both as their Pad item and as a
-- re-emitted drum note), so a .remotemap can bind individual pads per device.
-- Pad MIDI note (ch1) -> pad number (1-16).
gPadNoteLookup = {
	[0x10]=1,  [0x11]=2,  [0x12]=3,  [0x13]=4,  [0x14]=5,  [0x15]=6,  [0x16]=7,  [0x17]=8,   -- Bank A
	[0x20]=9,  [0x21]=10, [0x22]=11, [0x23]=12, [0x24]=13, [0x25]=14, [0x26]=15, [0x27]=16,  -- Bank B
}

-- CC number -> knob number (1-8)
gAnalogCCLookup = {
	[0x30]=1, [0x31]=2, [0x32]=3, [0x33]=4, -- Bank A: Knob 1-4, CC48-51
	[0x40]=5, [0x41]=6, [0x42]=7, [0x43]=8, -- Bank B: Knob 1-4, CC64-67
}

--------------------------------------------------------------------------
-- Device-aware pad behaviour
--------------------------------------------------------------------------
-- By default a pad press is emitted twice: as its mappable Pad item AND as a
-- re-emitted Keyboard drum note (so Kong/Redrum, which only trigger from
-- notes, still play). For the scopes listed below the drum note is NOT sent -
-- the pad drives its mapped Pad item only, so pads select/run things without
-- also playing notes on that device.
--
-- The scope name is the string Reason reports on the _Scope item, i.e. the
-- right-hand value of that scope's `Map _Scope "..."` line. Add a scope here
-- to silence its pad notes; remove it to restore drum-note behaviour.
gScopeItemIndex = 2 -- _Scope is item 2 in remote.define_items()
gScope = ""
-- Bank A pads on the scopes listed here select a pattern instead of sending
-- notes: each pad drives the single "Pattern" item (gPatternItemIndex) with
-- its index (padNumber-1, 0..7). Reason forbids mapping several surface items
-- to one remotable in a scope, so the Drum Sequencer scope maps that one item
-- once to Pattern Select (0 = Pattern 1, 7 = Pattern 8).
gPatternValueScopes = {
	["Drum Sequencer"] = true,
}
gPatternItemIndex = 30 -- the "Pattern" item is last in remote.define_items()
gSuppressPadNotes = {
	["Dr. Octo Rex"] = true,
	["Drum Sequencer"] = true, -- pads select patterns / transport, no notes
}

-- ID8 (stock instrument) exposes its current sound category as text. The ID8
-- scope maps ID8's "Category Name" remote item onto the "ID8 Category" surface
-- item below. When an ID8 is focused and its category is Drums we retarget the
-- Bank A pads to a General MIDI core drum kit (ID8's drum patches are General
-- MIDI mapped); any other category keeps the normal chromatic pad notes.
gId8CategoryItemIndex = 29 -- "ID8 Category" is the last item in define_items()
gId8Category = ""
gId8DrumNotes = {
	36, -- Pad 1  Bass Drum 1 (kick)
	38, -- Pad 2  Acoustic Snare
	42, -- Pad 3  Closed Hi-Hat
	46, -- Pad 4  Open Hi-Hat
	49, -- Pad 5  Crash Cymbal 1
	51, -- Pad 6  Ride Cymbal 1
	50, -- Pad 7  High Tom
	45, -- Pad 8  Low Tom
}

--------------------------------------------------------------------------
-- remote_init
--------------------------------------------------------------------------
function remote_init(manufacturer, model)
	local items = {
		{name="Keyboard", input="keyboard"},

		-- Scope-name display item consumed by "Map _Scope \"...\"" lines.
		{name="_Scope", output="text"},

		{name="Pad 1", input="button", min=0, max=127, output="value"},
		{name="Pad 2", input="button", min=0, max=127, output="value"},
		{name="Pad 3", input="button", min=0, max=127, output="value"},
		{name="Pad 4", input="button", min=0, max=127, output="value"},
		{name="Pad 5", input="button", min=0, max=127, output="value"},
		{name="Pad 6", input="button", min=0, max=127, output="value"},
		{name="Pad 7", input="button", min=0, max=127, output="value"},
		{name="Pad 8", input="button", min=0, max=127, output="value"},
		{name="Pad 9", input="button", min=0, max=127, output="value"},
		{name="Pad 10", input="button", min=0, max=127, output="value"},
		{name="Pad 11", input="button", min=0, max=127, output="value"},
		{name="Pad 12", input="button", min=0, max=127, output="value"},
		{name="Pad 13", input="button", min=0, max=127, output="value"},
		{name="Pad 14", input="button", min=0, max=127, output="value"},
		{name="Pad 15", input="button", min=0, max=127, output="value"},
		{name="Pad 16", input="button", min=0, max=127, output="value"},

		{name="Knob 1 A", input="value", output="value", min=0, max=127},
		{name="Knob 2 A", input="value", output="value", min=0, max=127},
		{name="Knob 3 A", input="value", output="value", min=0, max=127},
		{name="Knob 4 A", input="value", output="value", min=0, max=127},
		{name="Knob 1 B", input="value", output="value", min=0, max=127},
		{name="Knob 2 B", input="value", output="value", min=0, max=127},
		{name="Knob 3 B", input="value", output="value", min=0, max=127},
		{name="Knob 4 B", input="value", output="value", min=0, max=127},

		{name="Joystick X", input="value", min=0, max=16383},
		{name="Joystick Y", input="value", min=0, max=127},

		-- Text item the ID8 scope maps to ID8's "Category Name" remote item,
		-- so remote_set_state() can tell Drums from the other categories
		-- (index 29, see gId8CategoryItemIndex above).
		{name="ID8 Category", output="text"},

		-- Single value item the Drum Sequencer scope maps to "Pattern Select".
		-- The codec drives it from the Bank A pads (index 30).
		{name="Pattern", input="value", output="value", min=0, max=7},
	}
	remote.define_items(items)

	local inputs = {
		-- Keybed note data. Reason feeds the "Keyboard" item through explicit
		-- auto-input patterns (same idiom as Akai's factory codecs). The keybed
		-- transmits on MIDI channel 1 as notes 48-72; pad notes (16-23 / 32-39)
		-- are consumed in remote_process_midi() before they can reach these
		-- patterns, so they never leak into the Keyboard item.
		{pattern="8? xx yy", name="Keyboard", value="0", note="x", velocity="64"},
		{pattern="9? xx 00", name="Keyboard", value="0", note="x", velocity="64"},
		{pattern="<100x>? yy zz", name="Keyboard"},

		-- Joystick Y = CC16
		{pattern="b? 10 xx", name="Joystick Y"},

		-- Joystick X = Pitch Bend (status 0xE0, 14-bit LSB/MSB)
		{pattern="e? xx yy", name="Joystick X", value="y*128 + x"},
	}
	remote.define_auto_inputs(inputs)

	-- Pads are handled in remote_process_midi() below (emitted as Pad items
	-- and as drum notes); there is no control-surface item state to echo back
	-- to the hardware.
end

--------------------------------------------------------------------------
-- remote_set_state  (track the focused device name via the _Scope item)
--------------------------------------------------------------------------
-- Reason calls this whenever an item value changes. We capture two text items:
-- the _Scope text (which device is focused) and, when an ID8 is focused, its
-- "Category Name" (so pad notes can be special-cased for the Drums category).
function remote_set_state(changed_items)
	if remote.is_item_enabled(gScopeItemIndex) then
		gScope = remote.get_item_text_value(gScopeItemIndex)
	else
		gScope = ""
	end

	if remote.is_item_enabled(gId8CategoryItemIndex) then
		gId8Category = remote.get_item_text_value(gId8CategoryItemIndex)
	else
		gId8Category = ""
	end
end

--------------------------------------------------------------------------
-- remote_process_midi  (direct knob control + drum-pad notes)
--------------------------------------------------------------------------
-- Knob values are forwarded to Reason immediately (no soft takeover /
-- pickup), so every knob responds to the very first movement.
function remote_process_midi(event)
	local ret = remote.match_midi("b? yy xx", event)
	if ret ~= nil then
		local AnalogNum = gAnalogCCLookup[ret.y]
		if AnalogNum == nil then
			return false -- not a knob; let the auto-inputs handle it
		end

		remote.handle_input({
			time_stamp = event.time_stamp,
			item = gFirstAnalogIndex + AnalogNum - 1,
			value = ret.x,
		})
		return true
	end

	-- Pads: note on/off on MIDI channel 1, notes 16-23 (Bank A) / 32-39
	-- (Bank B). Reason drum devices (Kong, Redrum) fire their pads/drums from
	-- notes 36-51 (C1-D#2), so transpose each pad note into that range and
	-- re-emit it as a Keyboard note (item 1). The raw pad note is consumed so
	-- it never reaches the Keyboard auto-inputs; non-pad notes fall through
	-- (return false) and keep flowing to the keybed auto-inputs.
	-- In the same breath each pad press drives its matching Pad 1..16 item so
	-- a scope can bind pads per device (Dr. Octo Rex: Bank A -> Select Loop
	-- 1-8, Bank B pad 1 -> Run). The drum-note re-emission is skipped for any
	-- scope listed in gSuppressPadNotes.
	ret = remote.match_midi("<100x>? yy zz", event)
	if ret ~= nil then
		local PadNum = gPadNoteLookup[ret.y]
		if PadNum ~= nil then
			-- ret.x = 1 for note-on (status 0x9?), 0 for note-off (0x8?).
			local OnOff = (ret.x ~= 0 and ret.z > 0) and 1 or 0
			-- Drive the matching Pad 1..16 item (index 3 + PadNum - 1), so a
			-- .remotemap can bind individual pads per device (e.g. the Dr. Octo
			-- Rex scope maps Bank A to Select Loop 1-8 and Bank B pad 1 to
			-- Run). Devices that do not map these items ignore them.
			remote.handle_input({
				time_stamp = event.time_stamp,
				item = 2 + PadNum,      -- Pad 1 is index 3
				value = OnOff,
			})
			-- On a pattern-value scope, Bank A pads select a specific pattern.
			-- Since one remotable may only be mapped to a single surface item,
			-- every Bank A pad funnels its index (padNumber-1, 0..7) into the
			-- one "Pattern" item, which the scope maps to Pattern Select.
			if PadNum <= 8 and gPatternValueScopes[gScope] then
				remote.handle_input({
					time_stamp = event.time_stamp,
					item = gPatternItemIndex,
					value = PadNum - 1,
				})
			end
			-- Re-emit as a Keyboard drum note so Kong/Redrum play - unless the
			-- focused scope is in gSuppressPadNotes, in which case the pad
			-- only drives its Pad item (e.g. Dr. Octo Rex Select Loop / Run).
			if not gSuppressPadNotes[gScope] then
				-- Default target is the chromatic Kong/Redrum note 36..51.
				-- On an ID8 whose category is Drums, Bank A pads are converted
				-- instead to the General MIDI core kit (gId8DrumNotes): the
				-- raw pad note (16-23) becomes the matching GM drum note.
				local outNote = 35 + PadNum
				if PadNum <= 8 and gScope == "ID8"
					and string.find(string.lower(gId8Category), "drum", 1, true) ~= nil then
					outNote = gId8DrumNotes[PadNum]
				end
				remote.handle_input({
					time_stamp = event.time_stamp,
					item = 1,               -- Keyboard item
					value = OnOff,
					note = outNote,
					velocity = ret.z,
				})
			end
			return true
		end
	end

	return false
end

--------------------------------------------------------------------------
-- remote_probe  (disabled — see header note)
--------------------------------------------------------------------------
--[[
function remote_probe(manufacturer, model)
	return {
		request="f0 7e 7f 06 01 f7",
		response="f0 7e ?? 06 02 00 47 ?? ?? ????????????????????? f7"
	}
end
]]