# NN-XT Advanced Sampler — Test Plan

Device under test: **Akai MPK Mini Play** → **NN-XT** (`Maps/Akai/MPKMiniPlay.remotemap`)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1 Filter Freq     2 Filter Res       1 Amp Env Release     2 Mod Env Decay
   3 Amp Env Attack  4 Amp Env Decay    3 External Controller 4 Master Volume

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : X = Pitch Bend   Y = Mod Wheel
   Keyboard : notes 48-72 (velocity)
```

## Prerequisites

- [ ] Codec deployed to `Remote/Codecs/Lua Codecs/Akai/MPKMiniPlay.lua`
- [ ] Map deployed to `Remote/Maps/Akai/MPKMiniPlay.remotemap`
- [ ] Reason open with **NN-XT** as the focused/selected device
- [ ] Surface added manually in Preferences > Control Surfaces (Akai / MPK Mini Play)
- [ ] A multi-sample patch loaded

---

## 1. Pad triggering

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 1 | Tap Bank A pads 1-8 (hardware notes 16-23) | Sent as drum notes 36-43; ignored by the device (non-drum) | ☐ |
| 2 | Tap Bank B pads 9-16 (hardware notes 32-39) | Sent as drum notes 44-51; ignored by the device (non-drum) | ☐ |

## 2. Knob A/B switching

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 3 | Turn **Knob 1 A** (CC48) | **Filter Freq** moves | ☐ |
| 4 | Turn **Knob 2 A** (CC49) | **Filter Res** moves | ☐ |
| 5 | Turn **Knob 3 A** (CC50) | **Amp Env Attack** moves | ☐ |
| 6 | Turn **Knob 4 A** (CC51) | **Amp Env Decay** moves | ☐ |
| 7 | Turn **Knob 1 B** (CC64) | **Amp Env Release** moves | ☐ |
| 8 | Turn **Knob 2 B** (CC65) | **Mod Env Decay** moves | ☐ |
| 9 | Turn **Knob 3 B** (CC66) | **External Controller** moves | ☐ |
| 10 | Turn **Knob 4 B** (CC67) | **Master Volume** moves | ☐ |

## 3. Joystick behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 11 | Push joystick **left/right** | NN-XT **pitch bends** | ☐ |
| 12 | Push joystick **up/down** | **Mod Wheel** impacts the patch (if routed) | ☐ |
| 13 | Release joystick | Both axes return to centre | ☐ |

## 4. Keyboard behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 14 | Play across the keyboard split | Correct samples across key zones (velocity + key range) | ☐ |
| 15 | Vary velocity | Velocity layers crossfade correctly | ☐ |

## 5. Device parameter response

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 16 | Move **Filter Freq** with mouse | **Knob 1 A** recaptures on touch | ☐ |
| 17 | Load a new patch | Knob positions reflect the new patch's values | ☐ |

## 6. Remote Override compatibility

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 18 | Open Remote Overrides with NN-XT selected | Knobs 1-4A/B + Joystick X/Y listed | ☐ |
| 19 | Override **Knob 4 B** to `Amp Env Decay` | Combination knob now edits decay | ☐ |

## 7. Regression checklist

- [ ] No stuck notes across key velocity layers
- [ ] External Controller knob does not move other params
- [ ] Pad drum notes (36-51) are ignored by this non-drum device and never leak into the keybed