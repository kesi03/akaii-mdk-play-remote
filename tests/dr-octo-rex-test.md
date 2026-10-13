# Dr. Octo Rex Loop Player — Test Plan

Device under test: **Akai MPK Mini Play** → **Dr. Octo Rex Loop Player** (`Maps/Akai/MPKMiniPlay.remotemap`)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1 Master Level    2 Transpose       1 LFO1 Amount   2 Filter Mode
   3 Loop Transpose  4 Loop Level      3 LFO1 Wave     4 LFO1 Dest

   Pads     : Bank A pads 1-8 = Select Loop 1-8; Bank B pad 1 = Run
              (pads also re-emitted as drum notes 36-51)
   Joystick : X = Pitch Bend   Y = Mod Wheel
   Keyboard : notes 48-72 (velocity)
```

## Prerequisites

- [ ] Codec deployed to `Remote/Codecs/Lua Codecs/Akai/MPKMiniPlay.lua`
- [ ] Map deployed to `Remote/Maps/Akai/MPKMiniPlay.remotemap`
- [ ] Reason open with a **Dr. Octo Rex** as the focused/selected device (with a REX loop loaded in a loop slot)
- [ ] Surface added manually in Preferences > Control Surfaces (Akai / MPK Mini Play)
- [ ] MPK keybed/knobs/joystick on MIDI channel 1, pads on MIDI channel 1 (notes per `mapping/mpk-mini-play-controls.json`)

---

## 1. Scope attachment

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 1 | Select the Dr. Octo Rex device (it is the Dr. REX-compatible scope) | Control Surface shows "Dr. Octo Rex" as the active device scope | ☐ |
| 2 | Move a filter knob in the rack UI | Knob recaptures on touch — no red warning in Preferences > Control Surfaces | ☐ |

## 2. Pad behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 1 | Tap Bank A pads 1-8 (hardware notes 16-23) | Loops 1-8 are selected (Select Loop 1-8) | ☐ |
| 2 | Tap Bank B pad 1 (hardware note 32) | Loop playback toggles Run | ☐ |
| 3 | Tap Bank B pads 2-8 (hardware notes 33-39) | No mapped action (these pads are unassigned here) | ☐ |

## 3. Knob A/B switching

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 3 | Turn **Knob 1 A** (CC48) | **Master Level** (output volume) moves | ☐ |
| 4 | Turn **Knob 2 A** (CC49) | **Transpose** (global) moves | ☐ |
| 5 | Turn **Knob 3 A** (CC50) | **Loop Transpose** moves | ☐ |
| 6 | Turn **Knob 4 A** (CC51) | **Loop Level** moves | ☐ |
| 7 | Turn **Knob 1 B** (CC64) / **2 B** (CC65) / **3 B** (CC66) / **4 B** (CC67) | **LFO1 Amount**, **Filter Mode**, **LFO1 Wave**, **LFO1 Dest** move | ☐ |
| 8 | Switch hardware knob bank A<->B and re-check | Same CC numbers, mapped targets switch | ☐ |

## 4. Joystick behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 9 | Push joystick **left/right** | Octo Rex **pitch bends** the loop | ☐ |
| 10 | Push joystick **up/down** | **Mod Wheel** modulates the loop (audible filter/tone change) | ☐ |
| 11 | Release joystick | Pitch and mod return to centre/zero | ☐ |

## 5. Keyboard behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 12 | Play any key (C3..C5) | Slice/loop triggers per Note To Slot focus; D0 plays the focused slot loop (single-shot) | ☐ |
| 13 | Press E0..B0 | Selects Loop Slot 1-8 and starts playback of that loop | ☐ |

## 6. Remote Override compatibility

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 14 | Open Remote Overrides with Octo Rex selected | Knobs 1-4A/B + Joystick X/Y listed | ☐ |
| 15 | Override **Knob 4 B** to `Amp Env Attack` | Knob 4 B now shapes the amp attack of each slice | ☐ |
| 16 | Override **Knob 4 A** to `Enable Loop Playback` | Knob 4 A toggles loop playback on/off | ☐ |

## 7. Regression checklist

- [ ] Bank A pads select loops 1-8; Bank B pad 1 toggles Run
- [ ] Pad drum notes (36-51) do not leak into the keybed
- [ ] Pitch bend does not affect knobs or transport
- [ ] Knob movement does not retrigger slices
