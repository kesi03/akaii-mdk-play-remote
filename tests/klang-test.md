# Klang Tuned Percussion — Test Plan

Device under test: **Akai MPK Mini Play** → **Klang** (`Maps/Akai/MPKMiniPlay.remotemap`)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1 Filter_Cutoff   2 Filter_Reso    1 Synced_Delay_Time   2 Delay_Feedback
   3 Filter_Env      4 Amp_Velocity   3 Reverb_Time         4 Reverb_PreDelay

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : unmapped (Klang has no Pitch Bend / Mod Wheel)
   Keyboard : notes 48-72 (velocity)
```

## Prerequisites

- [ ] Codec deployed to `Remote/Codecs/Lua Codecs/Akai/MPKMiniPlay.lua`
- [ ] Map deployed to `Remote/Maps/Akai/MPKMiniPlay.remotemap`
- [ ] Reason open with **Klang** as the focused/selected device (any patch loaded)
- [ ] Surface added manually in Preferences > Control Surfaces (Akai / MPK Mini Play)
- [ ] MPK keybed/knobs/joystick on MIDI channel 1, pads on MIDI channel 1 (notes per `mapping/mpk-mini-play-controls.json`)

---

## 1. Scope attachment

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 1 | Select the Klang device | Control Surface shows "Klang" as the active device scope | ☐ |
| 2 | Wiggle a knob in the rack UI | Knob recaptures on touch — no red warning in Preferences > Control Surfaces | ☐ |

## 2. Pad behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 1 | Tap Bank A pads 1-8 (hardware notes 16-23) | Sent as drum notes 36-43; ignored by the device (non-drum) | ☐ |
| 2 | Tap Bank B pads 9-16 (hardware notes 32-39) | Sent as drum notes 44-51; ignored by the device (non-drum) | ☐ |

## 3. Knob A/B switching

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 5 | Turn **Knob 1 A** (CC48) | **Filter_Cutoff** moves | ☐ |
| 6 | Turn **Knob 2 A** (CC49) | **Filter_Reso** moves | ☐ |
| 7 | Turn **Knob 3 A** (CC50) | **Filter_Env** moves | ☐ |
| 8 | Turn **Knob 4 A** (CC51) | **Amp_Velocity** moves | ☐ |
| 9 | Turn **Knob 1 B** (CC64) | **Synced_Delay_Time** moves | ☐ |
| 10 | Turn **Knob 2 B** (CC65) | **Delay_Feedback** moves | ☐ |
| 11 | Turn **Knob 3 B** (CC66) | **Reverb_Time** moves | ☐ |
| 12 | Turn **Knob 4 B** (CC67) | **Reverb_PreDelay** moves | ☐ |
| 13 | Switch hardware knob bank A<->B and re-check | Same CC numbers, mapped targets switch | ☐ |

## 4. Joystick behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 14 | Push joystick left/right, up/down | No Klang response (pitch/mod not exposed; joystick unmapped) | ☐ |

## 5. Keyboard behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 15 | Play C3..C5 | Tuned percussion notes sound | ☐ |
| 16 | Vary velocity | Mallet/velocity response changes | ☐ |

## 6. Remote Override compatibility

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 17 | Open Remote Overrides with Klang selected | Knobs 1-4A/B listed (no Joystick) | ☐ |
| 18 | Override **Knob 4 B** to `Amp_Release` | Knob 4 B now controls the amp release | ☐ |

## 7. Regression checklist

- [ ] Pad drum notes (36-51) are ignored by this non-drum device and never leak into the keybed
- [ ] Joystick remains inert until overridden
- [ ] Knob movement does not retrigger notes