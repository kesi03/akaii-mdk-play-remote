# NN-19 Digital Sampler — Test Plan

Device under test: **Akai MPK Mini Play -> NN-19** (`Maps/Akai/MPKMiniPlay.remotemap`)

## Control map

```
   Knob A (CC48-51)                     Knob B (CC64-67)
   1 Filter Freq        2 Filter Res         1 Amp Env Attack     2 Amp Env Decay
   3 Filter Env Amount  4 LFO Rate           3 Amp Env Sustain    4 Amp Env Release

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : X = Pitch Bend   Y = Mod Wheel
   Keyboard : notes 48-72 (velocity)
```

## Prerequisites

- [ ] Codec deployed to `Remote/Codecs/Lua Codecs/Akai/MPKMiniPlay.lua`
- [ ] Map deployed to `Remote/Maps/Akai/MPKMiniPlay.remotemap`
- [ ] Reason open with **NN-19** as the focused/selected device
- [ ] Surface added manually in Preferences > Control Surfaces (Akai / MPK Mini Play)
- [ ] A sample loaded into the NN-19

---

## 1. Pad behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 1 | Tap Bank A pads 1-8 (hardware notes 16-23) | Sent as drum notes 36-43; ignored by the device (non-drum) | ☐ |
| 2 | Tap Bank B pads 9-16 (hardware notes 32-39) | Sent as drum notes 44-51; ignored by the device (non-drum) | ☐ |

## 2. Knob A/B switching

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 4 | Turn **Knob 1 A** (CC48) | **Filter Freq** moves | ☐ |
| 5 | Turn **Knob 2 A** (CC49) | **Filter Res** moves | ☐ |
| 6 | Turn **Knob 3 A** (CC50) | **Filter Env Amount** moves | ☐ |
| 7 | Turn **Knob 4 A** (CC51) | **LFO Rate** moves | ☐ |
| 8 | Turn **Knob 1 B** (CC64) | **Amp Env Attack** moves | ☐ |
| 9 | Turn **Knob 2 B** (CC65) | **Amp Env Decay** moves | ☐ |
| 10 | Turn **Knob 3 B** (CC66) | **Amp Env Sustain** moves | ☐ |
| 11 | Turn **Knob 4 B** (CC67) | **Amp Env Release** moves | ☐ |

## 3. Joystick behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 12 | Push joystick **left/right** | NN-19 **pitch bends** | ☐ |
| 13 | Push joystick **up/down** | **Mod Wheel** drives the patch's assigned mod-wheel routings | ☐ |
| 14 | Release joystick | Both axes return to centre | ☐ |

## 4. Keyboard behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 15 | Play across the keyboard | Sample plays at the correct pitch across the range | ☐ |
| 16 | Vary velocity | Amplitude / filter velocity response follows the patch | ☐ |

## 5. Device parameter response

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 17 | Move **Filter Freq** with the mouse | **Knob 1 A** recaptures on touch | ☐ |
| 18 | Load a new patch | Knob positions reflect the new patch's values | ☐ |

## 6. Remote Override compatibility

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 19 | Open Remote Overrides with NN-19 selected | Knobs 1-4A/B + Joystick X/Y listed | ☐ |
| 20 | Override **Knob 4 A** to `LFO Amount` | Combination knob now edits LFO amount | ☐ |

## 7. Regression checklist

- [ ] No stuck notes when key mode is set to mono/legato
- [ ] Changing patches does not leave the joystick latched
- [ ] Pad drum notes (36-51) are ignored by this non-drum device and never leak into the keybed
