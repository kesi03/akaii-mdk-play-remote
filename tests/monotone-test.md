# Monotone Bass Synthesizer — Test Plan

Device under test: **Akai MPK Mini Play** → **Monotone** (`Maps/Akai/MPKMiniPlay.remotemap`)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1 Osc Mix     2 Filter Freq   1 Amp Attack    2 Amp Decay
   3 Filter Reso 4 Filter Vel    3 Amp Sustain   4 Amp Release

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : X = Pitch Bend   Y = Mod Wheel
   Keyboard : notes 48-72 (velocity)
```

## Prerequisites

- [ ] Codec deployed to `Remote/Codecs/Lua Codecs/Akai/MPKMiniPlay.lua`
- [ ] Map deployed to `Remote/Maps/Akai/MPKMiniPlay.remotemap`
- [ ] Reason open with **Monotone** as the focused/selected device (any patch loaded)
- [ ] Surface added manually in Preferences > Control Surfaces (Akai / MPK Mini Play)
- [ ] MPK keybed/knobs/joystick on MIDI channel 1, pads on MIDI channel 1 (notes per `mapping/mpk-mini-play-controls.json`)

---

## 1. Scope attachment

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 1 | Select the Monotone device | Control Surface shows "Monotone" as the active device scope | ☐ |
| 2 | Wiggle a knob in the rack UI | Knob recaptures on touch — no red warning in Preferences > Control Surfaces | ☐ |

## 2. Pad behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 1 | Tap Bank A pads 1-8 (hardware notes 16-23) | Sent as drum notes 36-43; ignored by the device (non-drum) | ☐ |
| 2 | Tap Bank B pads 9-16 (hardware notes 32-39) | Sent as drum notes 44-51; ignored by the device (non-drum) | ☐ |

## 3. Knob A/B switching

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 5 | Turn **Knob 1 A** (CC48) | **Osc Mix** moves | ☐ |
| 6 | Turn **Knob 2 A** (CC49) | **Filter Freq** moves | ☐ |
| 7 | Turn **Knob 3 A** (CC50) | **Filter Reso** moves | ☐ |
| 8 | Turn **Knob 4 A** (CC51) | **Filter Vel** moves | ☐ |
| 9 | Turn **Knob 1 B** (CC64) / **2 B** (CC65) / **3 B** (CC66) / **4 B** (CC67) | **Amp Attack / Decay / Sustain / Release** move | ☐ |
| 10 | Switch hardware knob bank A<->B and re-check | Same CC numbers, mapped targets switch | ☐ |

## 4. Joystick behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 11 | Push joystick **left/right** | Monotone **pitch bends** | ☐ |
| 12 | Push joystick **up/down** | **Mod Wheel** modulates (filter movement) | ☐ |
| 13 | Release joystick | Pitch and mod return to centre/zero | ☐ |

## 5. Keyboard behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 14 | Play C1..C2 (mono synth range) | Notes sound through the Monotone patch | ☐ |
| 15 | Vary velocity | Monotone velocity response changes | ☐ |

## 6. Remote Override compatibility

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 16 | Open Remote Overrides with Monotone selected | Knobs 1-4A/B + Joystick X/Y listed | ☐ |
| 17 | Override **Knob 4 A** to `Filter Attack` | Knob 4 A shapes the filter envelope attack | ☐ |

## 7. Regression checklist

- [ ] Pad drum notes (36-51) are ignored by this non-drum device and never leak into the keybed
- [ ] Pitch bend does not affect knobs
- [ ] Knob movement does not retrigger notes
