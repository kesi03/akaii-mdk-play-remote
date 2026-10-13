# Europa Shapeshifting Synthesizer — Test Plan

Device under test: **Akai MPK Mini Play** → **Europa** (`Maps/Akai/MPKMiniPlay.remotemap`)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1 Filter Drive   2 Filter Reso   1 Amp Attack    2 Amp Decay
   3 Filter Freq    4 Master Volume 3 Amp Sustain   4 Amp Release

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : X = Pitch Bend   Y = Mod Wheel
   Keyboard : notes 48-72 (velocity)
```

## Prerequisites

- [ ] Codec deployed to `Remote/Codecs/Lua Codecs/Akai/MPKMiniPlay.lua`
- [ ] Map deployed to `Remote/Maps/Akai/MPKMiniPlay.remotemap`
- [ ] Reason open with **Europa** as the focused/selected device
- [ ] Surface added manually in Preferences > Control Surfaces (Akai / MPK Mini Play)
- [ ] MPK keybed/knobs/joystick on MIDI channel 1, pads on MIDI channel 1 (notes per `mapping/mpk-mini-play-controls.json`)

---

## 1. Scope attachment

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 1 | Select the Europa device | Control Surface shows "Europa" as the active device scope | ☐ |
| 2 | Wiggle a knob in the rack UI | Knob recaptures on touch — no red warning in Preferences > Control Surfaces | ☐ |

## 2. Pad behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 1 | Tap Bank A pads 1-8 (hardware notes 16-23) | Sent as drum notes 36-43; ignored by the device (non-drum) | ☐ |
| 2 | Tap Bank B pads 9-16 (hardware notes 32-39) | Sent as drum notes 44-51; ignored by the device (non-drum) | ☐ |

## 3. Knob A/B switching

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 3 | Turn **Knob 1 A** (CC48) | **Filter Drive** moves | ☐ |
| 4 | Turn **Knob 2 A** (CC49) | **Filter Reso** moves | ☐ |
| 5 | Turn **Knob 3 A** (CC50) | **Filter Freq** moves | ☐ |
| 6 | Turn **Knob 4 A** (CC51) | **Master Volume** moves | ☐ |
| 7 | Turn **Knob 1 B** (CC64) / **2 B** (CC65) / **3 B** (CC66) / **4 B** (CC67) | **Amp Attack / Decay / Sustain / Release** move | ☐ |
| 8 | Switch hardware knob bank A<->B and re-check | Same CC numbers, mapped targets switch | ☐ |

## 4. Joystick behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 9 | Push joystick **left/right** | Europa **pitch bends** | ☐ |
| 10 | Push joystick **up/down** | Europa **Mod Wheel** modulates (e.g. filter) | ☐ |
| 11 | Release joystick | Pitch and mod return to centre/zero | ☐ |

## 5. Keyboard behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 12 | Play C3..C5 | Notes sound through the Europa patch | ☐ |
| 13 | Vary velocity | Europa velocity response changes | ☐ |

## 6. Remote Override compatibility

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 14 | Open Remote Overrides with Europa selected | Knobs 1-4A/B + Joystick X/Y listed | ☐ |
| 15 | Override **Knob 4 A** to `Osc1 Filter Freq` | Knob 4 A now sweeps Osc 1's filter | ☐ |
| 16 | Override **Knob 4 A** to `Osc3 Filter Reso` | Knob 4 A steps Osc 3 filter resonance | ☐ |

## 7. Regression checklist

- [ ] Pad drum notes (36-51) are ignored by this non-drum device and never leak into the keybed
- [ ] Pitch bend does not affect knobs
- [ ] Knob movement does not retrigger notes
