# ID8 Instrument Device — Test Plan

Device under test: **Akai MPK Mini Play** → **ID8** (`Maps/Akai/MPKMiniPlay.remotemap`)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1 Volume   2 Parameter 1   1 (unmapped)   2 (unmapped)
   3 Parameter 2   4 (unmapped)   3 (unmapped)   4 (unmapped)

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : unmapped
   Keyboard : notes 48-72 (velocity)
```

## Prerequisites

- [ ] Codec deployed to `Remote/Codecs/Lua Codecs/Akai/MPKMiniPlay.lua`
- [ ] Map deployed to `Remote/Maps/Akai/MPKMiniPlay.remotemap`
- [ ] Reason open with **ID8** as the focused/selected device (a multi-instrument patch loaded)
- [ ] Surface added manually in Preferences > Control Surfaces (Akai / MPK Mini Play)
- [ ] MPK keybed/knobs/joystick on MIDI channel 1, pads on MIDI channel 1 (notes per `mapping/mpk-mini-play-controls.json`)

---

## 1. Scope attachment

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 1 | Select the ID8 device | Control Surface shows "ID8" as the active device scope | ☐ |
| 2 | Wiggle a knob in the rack UI | Knob recaptures on touch — no red warning in Preferences > Control Surfaces | ☐ |

## 2. Pad behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 1 | Tap Bank A pads 1-8 (hardware notes 16-23) | Sent as drum notes 36-43; ignored by the device (non-drum) | ☐ |
| 2 | Tap Bank B pads 9-16 (hardware notes 32-39) | Sent as drum notes 44-51; ignored by the device (non-drum) | ☐ |

## 3. Knob A/B switching

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 10 | Turn **Knob 1 A** (CC48) | **Volume** moves | ☐ |
| 11 | Turn **Knob 2 A** (CC49) | **Parameter 1** moves | ☐ |
| 12 | Turn **Knob 3 A** (CC50) | **Parameter 2** moves | ☐ |
| 13 | Turn **Knob 4 A** (CC51) or any **1-4 B** (CC64-67) | No response (ID8 exposes only 3 parameters; reserved) | ☐ |

## 4. Joystick behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 14 | Push joystick left/right, up/down | No ID8 response (pitch/mod not exposed; joystick unmapped) | ☐ |

## 5. Keyboard behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 15 | Play C3..C5 | The instrument of the selected sound/range sounds | ☐ |
| 16 | Select a different category in the ID8 UI | New instrument/sound is playable from the same keys | ☐ |

## 6. Remote Override compatibility

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 17 | Open Remote Overrides with ID8 selected | Knobs 1-4A/B listed (no Joystick) | ☐ |
| 18 | Override **Knob 4 A** to `Volume` | Knob 4 A duplicates the ID8 volume | ☐ |

## 7. Regression checklist

- [ ] Pad drum notes (36-51) are ignored by this non-drum device and never leak into the keybed
- [ ] Category/sound jumps do not disturb sequencer clock
- [ ] Knob B bank stays silent until overridden
