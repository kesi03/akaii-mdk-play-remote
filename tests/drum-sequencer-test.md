# Drum Sequencer — Test Plan

Device under test: **Akai MPK Mini Play** → **Drum Sequencer** (Player) (`Maps/Akai/MPKMiniPlay.remotemap`)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   (unmapped on this scope)  (unmapped on this scope)

   Pads     : Bank A pads 1-8 = Pattern 1-8; Bank B pad 1 = Record, pad 2 = Play
              (drum notes 36-51 are suppressed for this scope)
   Joystick : X = Pitch Bend   Y = Mod Wheel
   Keyboard : notes 48-72 (passes through the player)
```

## Prerequisites

- [ ] Codec deployed to `Remote/Codecs/Lua Codecs/Akai/MPKMiniPlay.lua`
- [ ] Map deployed to `Remote/Maps/Akai/MPKMiniPlay.remotemap`
- [ ] Reason open with a **Drum Sequencer** player as the focused/selected device (with an instrument — e.g. Kong — placed below it)
- [ ] Surface added manually in Preferences > Control Surfaces (Akai / MPK Mini Play)
- [ ] MPK keybed/knobs/joystick on MIDI channel 1, pads on MIDI channel 1 (notes per `mapping/mpk-mini-play-controls.json`)

---

## 1. Scope attachment

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 1 | Select the Drum Sequencer device | Control Surface shows "Drum Sequencer" as the active device scope | ☐ |
| 2 | Move a knob in the rack UI for a mapped item | No red warning in Preferences > Control Surfaces (the surface still owns its scoped items) | ☐ |

## 2. Pad behaviour — Bank A (patterns)

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 3 | Tap **Bank A pad 1** (hardware note 16) | **Pattern 1** is selected | ☐ |
| 4 | Tap **Bank A pad 8** (hardware note 23) | **Pattern 8** is selected | ☐ |
| 5 | Tap Bank A pads 2-7 in turn | Patterns 2-7 are selected in that order | ☐ |
| 6 | Release a pad after tapping it | The selected pattern **stays** (does not jump back to Pattern 1) | ☐ |

## 3. Pad behaviour — Bank B (transport)

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 7 | Tap **Bank B pad 1** (hardware note 32) | Drum Sequencer **Record** toggles on/off (armed indicator) | ☐ |
| 8 | Tap **Bank B pad 2** (hardware note 33) | Drum Sequencer **Play** toggles on/off | ☐ |
| 9 | Tap Bank B pads 4, 6, 7, 8 (notes 35, 37, 38, 39) | No mapped action on this scope | ☐ |
| 10 | Tap any Bank A/B pad while a Kong is placed below the player | **No drum note is played** (pad notes are suppressed for this scope) | ☐ |

## 4. Knob behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 11 | Turn **Knob 1-4 A** (CC48-51) and **Knob 1-4 B** (CC64-67) | No parameter moves on the Drum Sequencer (this scope maps no knobs) | ☐ |

## 5. Joystick behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 12 | Push joystick **left/right** | Pitch bend is sent through the player to the instrument below | ☐ |
| 13 | Push joystick **up/down** | Mod wheel (CC16) is sent through the player | ☐ |

## 6. Keyboard behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 14 | Play any key (C3..C5) | The note passes through the player and plays the instrument below | ☐ |
| 15 | Play a note while Record is armed | The note is recorded into the current pattern | ☐ |

## 7. Remote Override compatibility

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 16 | Open Remote Overrides with the Drum Sequencer selected | The mapped Pad items are listed | ☐ |
| 17 | Override **Bank A pad 1** to `On` | Pad 1 now toggles the player On/off instead of selecting Pattern 1 | ☐ |

## 8. Regression checklist

- [ ] Bank A pads 1-8 select patterns 1-8 (not "Pattern Select untouched")
- [ ] Bank B pad 1/2 toggle Record/Play; no other Bank B pad acts on this scope
- [ ] Pad drum notes (36-51) do not leak to the instrument below while this scope is focused
- [ ] Bank B pad 1 still toggles Dr. Octo Rex `Run` when a Dr. Octo Rex is focused
- [ ] Bank B pads 3 and 5 bypass/enable a focused Combinator
- [ ] Patterns and transport still respond after switching focus away and back
