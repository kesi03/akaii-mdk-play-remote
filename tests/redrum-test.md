# Redrum Drum Computer — Test Plan

Device under test: **Akai MPK Mini Play** → **Redrum Drum Computer** (`Maps/Akai/MPKMiniPlay.remotemap`)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1 Drum 1 Level   2 Drum 2 Level   1 Drum 1 Pan   2 Drum 2 Pan
   3 Drum 3 Level   4 Drum 4 Level   3 Drum 3 Pan   4 Drum 4 Pan

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : unmapped
   Keyboard : notes 48-72 (velocity)
```

## Prerequisites

- [ ] Codec deployed to `Remote/Codecs/Lua Codecs/Akai/MPKMiniPlay.lua`
- [ ] Map deployed to `Remote/Maps/Akai/MPKMiniPlay.remotemap`
- [ ] Reason open with **Redrum** as the focused/selected device
- [ ] Surface added manually in Preferences > Control Surfaces (Akai / MPK Mini Play)

---

## 1. Pad triggering

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 1 | Tap Bank A pads 1-8 (hardware notes 16-23) | Sent as drum notes 36-43; Redrum drums/channels respond (Redrum is note-triggered 36-51) | ☐ |
| 2 | Tap Bank B pads 9-16 (hardware notes 32-39) | Sent as drum notes 44-51; Redrum drums/channels respond | ☐ |

## 2. Knob A/B switching

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 7 | Turn **Knob 1 A** (CC48) | **Drum 1 Level** moves | ☐ |
| 8 | Turn **Knob 2 A** (CC49) / **3 A** (CC50) / **4 A** (CC51) | **Drum 2/3/4 Level** move | ☐ |
| 9 | Turn **Knob 1 B** (CC64) | **Drum 1 Pan** moves | ☐ |
| 10 | Turn **Knob 2 B** (CC65) / **3 B** (CC66) / **4 B** (CC67) | **Drum 2/3/4 Pan** move | ☐ |
| 11 | Switch hardware knob bank A<->B and re-check | Same CCs drive levels vs pans correctly | ☐ |

## 3. Joystick behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 12 | Push joystick X and Y | No mapped response by default (Redrum has no pitch/mod) | ☐ |
| 13 | Apply a Remote Override re-pointing Joystick Y to `Master Level` | Joystick Y now controls Redrum master level | ☐ |

## 4. Keyboard behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 14 | Play keys C0..C2 (notes 36, 38, 40, 41, 43...) | Redrum triggers the corresponding drum (default keymap) | ☐ |
| 15 | Vary velocity | Drum hit velocity tracks velocity | ☐ |

## 5. Device parameter response

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 16 | Move **Drum 1 Level** with mouse | **Knob 1 A** recaptures position | ☐ |
| 17 | Change Redrum pattern in UI | Redrum pattern changes; the MPK pads are note triggers, not pattern selectors | ☐ |

## 6. Remote Override compatibility

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 18 | Open Remote Overrides with Redrum selected | Knobs 1-4A/B listed | ☐ |
| 19 | Override **Knob 4 B** to a target of your choice | Re-mapping works without editing the map file | ☐ |

## 7. Regression checklist

- [ ] Pads trigger Redrum drums via drum notes (36-51)
- [ ] Pad drum notes (36-51) do not leak into the keybed; playing pads then keys leaves no stuck notes
- [ ] Knob movements do not select sounds
