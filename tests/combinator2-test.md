# Combinator 2 — Test Plan

Device under test: **Akai MPK Mini Play** → **Combinator** (`Maps/Akai/MPKMiniPlay.remotemap`)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1 Rotary 1   2 Rotary 2   1 Enabled    2 Run Pattern Devices
   3 Rotary 3   4 Rotary 4   3 Bypass All FX  4 Select Patch Delta

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : X = Pitch Bend   Y = Mod Wheel
   Keyboard : notes 48-72 (velocity)
```

## Prerequisites

- [ ] Codec deployed to `Remote/Codecs/Lua Codecs/Akai/MPKMiniPlay.lua`
- [ ] Map deployed to `Remote/Maps/Akai/MPKMiniPlay.remotemap`
- [ ] Reason open with a **Combinator** as the focused/selected device
- [ ] Combinator front panel has rotaries **and** buttons programmed
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
| 4 | Turn **Knob 1 A** (CC48) | **Rotary 1** moves | ☐ |
| 5 | Turn **Knob 2 A** (CC49) / **3 A** (CC50) / **4 A** (CC51) | **Rotary 2/3/4** move | ☐ |
| 6 | Turn **Knob 1 B** (CC64) | Combinator **Enabled** toggles | ☐ |
| 7 | Turn **Knob 2 B** (CC65) / **3 B** (CC66) | **Run Pattern Devices** / **Bypass All FX** toggle | ☐ |
| 8 | Turn **Knob 4 B** (CC67) sweep | **Select Patch Delta** steps the patch list | ☐ |

## 3. Joystick behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 8 | Push joystick **left/right** | Combinator instrument **pitch bends** | ☐ |
| 9 | Push joystick **up/down** | **Mod Wheel** routes to the programmed device | ☐ |
| 10 | Release joystick | Both axes return to centre | ☐ |

## 4. Keyboard behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 11 | Play C3..C5 | Notes sound through the Combinator's internal chain | ☐ |
| 12 | Vary velocity | Velocity routed as programmed in the Combi | ☐ |

## 5. Device parameter response

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 13 | Move a Rotary with mouse | Matching knob recaptures on touch | ☐ |
| 14 | Toggle a Button with mouse | Matching knob LED reflects the state | ☐ |

## 6. Remote Override compatibility

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 15 | Open Remote Overrides with the Combinator selected | Rotaries, buttons, joystick listed | ☐ |
| 16 | Override **Knob 4 A** to `Rotary 3` | Knob 4 A now drives rotary 3 | ☐ |

## 7. Regression checklist

- [ ] Buttons latch correctly via knob-turn on/off
- [ ] Rotary values don't jump when switching between Combinator patches
- [ ] Pad drum notes (36-51) are ignored by this non-drum device and never leak into the keybed
