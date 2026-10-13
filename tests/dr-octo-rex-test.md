# Dr. Octo Rex Loop Player — Test Plan

Device under test: **Akai MPK Mini Play** → **Dr. Octo Rex Loop Player** (`Maps/Akai/MPKMiniPlay.remotemap`)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1 Filter Freq   2 Filter Res   1 LFO1 Amount   2 Filter Mode
   3 Filter Env    4 LFO1 Rate    3 LFO1 Wave     4 LFO1 Dest

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
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
| 1 | Tap Bank A pads 1-8 (hardware notes 16-23) | Sent as drum notes 36-43; ignored by the device (non-drum) | ☐ |
| 2 | Tap Bank B pads 9-16 (hardware notes 32-39) | Sent as drum notes 44-51; ignored by the device (non-drum) | ☐ |

## 3. Knob A/B switching

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 3 | Turn **Knob 1 A** (CC48) | **Filter Freq** moves | ☐ |
| 4 | Turn **Knob 2 A** (CC49) | **Filter Res** moves | ☐ |
| 5 | Turn **Knob 3 A** (CC50) | **Filter Env Amount** moves | ☐ |
| 6 | Turn **Knob 4 A** (CC51) | **LFO1 Rate** moves | ☐ |
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

- [ ] Pad drum notes (36-51) are ignored by this non-drum device and never leak into the keybed
- [ ] Pitch bend does not affect knobs or transport
- [ ] Knob movement does not retrigger slices
