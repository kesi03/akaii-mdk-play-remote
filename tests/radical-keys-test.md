# Radical Keys — Test Plan

Device under test: **Akai MPK Mini Play** → **Radical Keys** (`Maps/Akai/MPKMiniPlay.remotemap`)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1 Character   2 Instrument Blend   1 Env Attack   2 Env Decay Curve
   3 Vel Resp Curve   4 Master Volume 3 Env Release  4 Comp Amount

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : X = Pitch Bend   (Y unmapped; no Mod Wheel remotable)
   Keyboard : notes 48-72 (velocity)
```

## Prerequisites

- [ ] Codec deployed to `Remote/Codecs/Lua Codecs/Akai/MPKMiniPlay.lua`
- [ ] Map deployed to `Remote/Maps/Akai/MPKMiniPlay.remotemap`
- [ ] Reason open with **Radical Keys** as the focused/selected device (any patch loaded)
- [ ] Surface added manually in Preferences > Control Surfaces (Akai / MPK Mini Play)
- [ ] MPK keybed/knobs/joystick on MIDI channel 1, pads on MIDI channel 1 (notes per `mapping/mpk-mini-play-controls.json`)

---

## 1. Scope attachment

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 1 | Select the Radical Keys device | Control Surface shows "Radical Keys" as the active device scope | ☐ |
| 2 | Wiggle a knob in the rack UI | Knob recaptures on touch — no red warning in Preferences > Control Surfaces | ☐ |
| 3 | Confirm scope id | Advanced Remote info shows `Propellerhead Software` / `se.propellerheads.RadicalKeys` (CamelCase) | ☐ |

## 2. Pad behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 1 | Tap Bank A pads 1-8 (hardware notes 16-23) | Sent as drum notes 36-43; ignored by the device (non-drum) | ☐ |
| 2 | Tap Bank B pads 9-16 (hardware notes 32-39) | Sent as drum notes 44-51; ignored by the device (non-drum) | ☐ |

## 3. Knob A/B switching

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 7 | Turn **Knob 1 A** (CC48) | **Character** moves | ☐ |
| 8 | Turn **Knob 2 A** (CC49) | **Instrument Blend** moves | ☐ |
| 9 | Turn **Knob 3 A** (CC50) | **Vel Resp Curve** moves | ☐ |
| 10 | Turn **Knob 4 A** (CC51) | **Master Volume** moves | ☐ |
| 11 | Turn **Knob 1 B** (CC64) / **2 B** (CC65) / **3 B** (CC66) | **Env Attack**, **Env Decay Curve**, **Env Release** move | ☐ |
| 12 | Turn **Knob 4 B** (CC67) | **Comp Amount** moves | ☐ |
| 13 | Switch hardware knob bank A<->B and re-check | Same CC numbers, mapped targets switch | ☐ |

## 4. Joystick behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 14 | Push joystick **left/right** | Radical Keys **pitch bends** | ☐ |
| 15 | Push joystick **up/down** | No response (no Mod Wheel remotable); retarget via override if desired | ☐ |
| 16 | Release joystick | Pitch returns to centre | ☐ |

## 5. Keyboard behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 17 | Play C3..C5 | Notes sound through the Radical Keys patch | ☐ |
| 18 | Vary velocity | Timbre responds across the velocity layers | ☐ |

## 6. Remote Override compatibility

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 19 | Open Remote Overrides with Radical Keys selected | Knobs 1-4A/B + Joystick X listed | ☐ |
| 20 | Override **Ambience Level** onto Knob 4 B | Knob drives ambience instead of comp | ☐ |

## 7. Regression checklist

- [ ] Pad drum notes (36-51) are ignored by this non-drum device and never leak into the keybed
- [ ] Pitch bend does not affect knobs
- [ ] Knob movement does not retrigger notes
