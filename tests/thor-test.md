# Thor Polysonic Synthesizer — Test Plan

Device under test: **Akai MPK Mini Play** → **Thor** (`Maps/Akai/MPKMiniPlay.remotemap`)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1 Filter 1 Freq   2 Filter 1 Res   1 Amp Env Attack    2 Amp Env Decay
   3 Filter 2 Freq   4 Filter 2 Res   3 Amp Env Sustain   4 Amp Env Release

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : X = Pitch Bend   Y = Mod Wheel
   Keyboard : notes 48-72 (velocity)
```

## Prerequisites

- [ ] Codec deployed to `Remote/Codecs/Lua Codecs/Akai/MPKMiniPlay.lua`
- [ ] Map deployed to `Remote/Maps/Akai/MPKMiniPlay.remotemap`
- [ ] Reason open with **Thor** as the focused/selected device
- [ ] Surface added manually in Preferences > Control Surfaces (Akai / MPK Mini Play)

---

## 1. Pad triggering

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 1 | Tap Bank A pads 1-8 (hardware notes 16-23) | Sent as drum notes 36-43; ignored by the device (non-drum) | ☐ |
| 2 | Tap Bank B pads 9-16 (hardware notes 32-39) | Sent as drum notes 44-51; ignored by the device (non-drum) | ☐ |

## 2. Knob A/B switching

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 3 | Turn **Knob 1 A** (CC48) | **Filter 1 Freq** moves | ☐ |
| 4 | Turn **Knob 2 A** (CC49) | **Filter 1 Res** moves | ☐ |
| 5 | Turn **Knob 3 A** (CC50) | **Filter 2 Freq** moves | ☐ |
| 6 | Turn **Knob 4 A** (CC51) | **Filter 2 Res** moves | ☐ |
| 7 | Turn **Knob 1 B** (CC64) | **Amp Env Attack** moves | ☐ |
| 8 | Turn **Knob 2 B** (CC65) / **3 B** (CC66) / **4 B** (CC67) | **Amp Env Decay / Sustain / Release** move | ☐ |

## 3. Joystick behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 9 | Push joystick **left/right** | Thor **pitch bends** | ☐ |
| 10 | Push joystick **up/down** | Thor **Mod Wheel** routing (e.g. to filter cutoff) | ☐ |
| 11 | Release joystick | Both axes return to centre | ☐ |

## 4. Keyboard behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 12 | Play C3..C5 | Notes sound through Thor patch | ☐ |
| 13 | Vary velocity | Velocity response audible | ☐ |

## 5. Device parameter response

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 14 | Move **Filter 1 Freq** with mouse | **Knob 1 A** recaptures on touch | ☐ |
| 15 | Switch Thor patch with mouse | Knobs re-target to the new patch's assigned values | ☐ |

## 6. Remote Override compatibility

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 16 | Open Remote Overrides with Thor selected | Knobs 1-4A/B + Joystick X/Y listed | ☐ |
| 17 | Override **Knob 4 A** to `Filter 3 Drive` | Knob 4 A drives the drive section | ☐ |

## 7. Regression checklist

- [ ] No pitch bend bleed into knob values
- [ ] Pad drum notes (36-51) are ignored by this non-drum device and never leak into the keybed
- [ ] Legato/portamento unaffected by joystick use