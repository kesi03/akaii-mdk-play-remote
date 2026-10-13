# Radical Piano — Test Plan

Device under test: **Akai MPK Mini Play** → **Radical Piano** (`Maps/Akai/MPKMiniPlay.remotemap`)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1 Character            2 Microphone 1 Type   1 Env Attack   2 Env Decay Curve
   3 Mic/Instrument Blend 4 Microphone 2 Type   3 Env Release  4 Master Volume

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : X = Pitch Bend   (Y unmapped; no Mod Wheel remotable)
   Keyboard : notes 48-72 (velocity)
```

## Prerequisites

- [ ] Codec deployed to `Remote/Codecs/Lua Codecs/Akai/MPKMiniPlay.lua`
- [ ] Map deployed to `Remote/Maps/Akai/MPKMiniPlay.remotemap`
- [ ] Reason open with **Radical Piano** as the focused/selected device (any patch loaded)
- [ ] Surface added manually in Preferences > Control Surfaces (Akai / MPK Mini Play)
- [ ] MPK keybed/knobs/joystick on MIDI channel 1, pads on MIDI channel 1 (notes per `mapping/mpk-mini-play-controls.json`)

---

## 1. Scope attachment

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 1 | Select the Radical Piano device | Control Surface shows "Radical Piano" as the active device scope | ☐ |
| 2 | Wiggle a knob in the rack UI | Knob recaptures on touch — no red warning in Preferences > Control Surfaces | ☐ |

## 2. Pad behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 1 | Tap Bank A pads 1-8 (hardware notes 16-23) | Sent as drum notes 36-43; ignored by the device (non-drum) | ☐ |
| 2 | Tap Bank B pads 9-16 (hardware notes 32-39) | Sent as drum notes 44-51; ignored by the device (non-drum) | ☐ |

## 3. Knob A/B switching

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 5 | Turn **Knob 1 A** (CC48) | **Character** moves | ☐ |
| 6 | Turn **Knob 2 A** (CC49) | **Microphone 1 Type** moves | ☐ |
| 7 | Turn **Knob 3 A** (CC50) | **Microphone and Instrument Blend** moves | ☐ |
| 8 | Turn **Knob 4 A** (CC51) | **Microphone 2 Type** moves | ☐ |
| 9 | Turn **Knob 1 B** (CC64) / **2 B** (CC65) / **3 B** (CC66) | **Env Attack**, **Env Decay Curve**, **Env Release** move | ☐ |
| 10 | Turn **Knob 4 B** (CC67) | **Master Volume** moves | ☐ |
| 11 | Switch hardware knob bank A<->B and re-check | Same CC numbers, mapped targets switch | ☐ |

## 4. Joystick behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 12 | Push joystick **left/right** | Radical Piano **pitch bends** | ☐ |
| 13 | Push joystick **up/down** | No response (no Mod Wheel remotable); retarget via override if desired | ☐ |
| 14 | Release joystick | Pitch returns to centre | ☐ |

## 5. Keyboard behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 15 | Play C3..C5 | Notes sound through the Radical Piano patch | ☐ |
| 16 | Vary velocity | Piano timbre responds across the velocity layers | ☐ |

## 6. Remote Override compatibility

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 17 | Open Remote Overrides with Radical Piano selected | Knobs 1-4A/B + Joystick X listed | ☐ |
| 18 | Override **Knob 4 A** to `Microphone 1 Type` | Knob 4 A steps mic configuration 1 | ☐ |

## 7. Regression checklist

- [ ] Pad drum notes (36-51) are ignored by this non-drum device and never leak into the keybed
- [ ] Pitch bend does not affect knobs
- [ ] Knob movement does not retrigger notes
