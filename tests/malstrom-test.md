# Malstrom Graintable Synthesizer — Test Plan

Device under test: **Akai MPK Mini Play** → **Malstrom** (`Maps/Akai/MPKMiniPlay.remotemap`)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1 Filter A Freq   2 Filter A Res   1 Modulator A Rate    2 Modulator B Rate
   3 Filter B Freq   4 Filter B Res   3 Oscillator A Motion 4 Oscillator B Motion

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : X = Pitch Bend   Y = Mod Wheel
   Keyboard : notes 48-72 (velocity)
```

## Prerequisites

- [ ] Codec deployed to `Remote/Codecs/Lua Codecs/Akai/MPKMiniPlay.lua`
- [ ] Map deployed to `Remote/Maps/Akai/MPKMiniPlay.remotemap`
- [ ] Reason open with **Malstrom** as the focused/selected device (any patch loaded)
- [ ] Surface added manually in Preferences > Control Surfaces (Akai / MPK Mini Play)
- [ ] MPK keybed/knobs/joystick on MIDI channel 1, pads on MIDI channel 1 (notes per `mapping/mpk-mini-play-controls.json`)

---

## 1. Scope attachment

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 1 | Select the Malstrom device | Control Surface shows "Malstrom" as the active device scope | ☐ |
| 2 | Wiggle a knob in the rack UI | Knob recaptures on touch — no red warning in Preferences > Control Surfaces | ☐ |

## 2. Pad behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 1 | Tap Bank A pads 1-8 (hardware notes 16-23) | Sent as drum notes 36-43; ignored by the device (non-drum) | ☐ |
| 2 | Tap Bank B pads 9-16 (hardware notes 32-39) | Sent as drum notes 44-51; ignored by the device (non-drum) | ☐ |

## 3. Knob A/B switching

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 5 | Turn **Knob 1 A** (CC48) | **Filter A Freq** moves | ☐ |
| 6 | Turn **Knob 2 A** (CC49) | **Filter A Resonance** moves | ☐ |
| 7 | Turn **Knob 3 A** (CC50) | **Filter B Freq** moves | ☐ |
| 8 | Turn **Knob 4 A** (CC51) | **Filter B Resonance** moves | ☐ |
| 9 | Turn **Knob 1 B** (CC64) / **2 B** (CC65) | **Modulator A Rate**, **Modulator B Rate** move | ☐ |
| 10 | Turn **Knob 3 B** (CC66) / **4 B** (CC67) | **Oscillator A Motion**, **Oscillator B Motion** move | ☐ |
| 11 | Switch hardware knob bank A<->B and re-check | Same CC numbers, mapped targets switch | ☐ |

## 4. Joystick behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 12 | Push joystick **left/right** | Malstrom **pitch bends** | ☐ |
| 13 | Push joystick **up/down** | **Mod Wheel** modulates (moving the graintable) | ☐ |
| 14 | Release joystick | Pitch and mod return to centre/zero | ☐ |

## 5. Keyboard behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 15 | Play C3..C5 | Notes sound through the Malstrom patch | ☐ |
| 16 | Vary velocity | Malstrom velocity response changes | ☐ |

## 6. Remote Override compatibility

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 17 | Open Remote Overrides with Malstrom selected | Knobs 1-4A/B + Joystick X/Y listed | ☐ |
| 18 | Override **Knob 4 A** to `Filter Env Attack` | Knob 4 A shapes the filter envelope attack | ☐ |

## 7. Regression checklist

- [ ] Pad drum notes (36-51) are ignored by this non-drum device and never leak into the keybed
- [ ] Pitch bend does not affect knobs
- [ ] Knob movement does not retrigger notes
