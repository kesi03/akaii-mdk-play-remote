# Rytmik Drum Machine — Test Plan

Device under test: **Akai MPK Mini Play** → **Rytmik Drum Machine** (`Maps/Akai/MPKMiniPlay.remotemap`)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1 Drum 1 Volume   2 Drum 2 Volume   1 Drum 5 Volume   2 Drum 6 Volume
   3 Drum 3 Volume   4 Drum 4 Volume   3 Drum 7 Volume   4 Drum 8 Volume

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : unmapped
   Keyboard : notes 48-72 (velocity)
```

## Prerequisites

- [ ] Codec deployed to `Remote/Codecs/Lua Codecs/Akai/MPKMiniPlay.lua`
- [ ] Map deployed to `Remote/Maps/Akai/MPKMiniPlay.remotemap`
- [ ] Reason open with a **Rytmik** as the focused/selected device
- [ ] Surface added manually in Preferences > Control Surfaces (Akai / MPK Mini Play)
- [ ] MPK keybed/knobs/joystick on MIDI channel 1, pads on MIDI channel 1 (notes per `mapping/mpk-mini-play-controls.json`)

---

## 1. Scope attachment

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 1 | Select the Rytmik device (scope `se.propellerheads.DMFC`) | Control Surface shows "Rytmik" as the active device scope | ☐ |
| 2 | Move a **Drum 1 Volume** in the rack UI | Knob recaptures on touch — no red warning in Preferences > Control Surfaces | ☐ |

## 2. Pad triggering

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 1 | Tap Bank A pads 1-8 (hardware notes 16-23) | Sent as drum notes 36-43; Rytmik channels respond | ☐ |
| 2 | Tap Bank B pads 9-16 (hardware notes 32-39) | Sent as drum notes 44-51; Rytmik channels respond | ☐ |

## 3. Knob A/B switching

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 3 | Turn **Knob 1 A** (CC48) / **2 A** (CC49) / **3 A** (CC50) / **4 A** (CC51) | **Drum 1-4 Volume** move | ☐ |
| 4 | Turn **Knob 1 B** (CC64) / **2 B** (CC65) / **3 B** (CC66) / **4 B** (CC67) | **Drum 5-8 Volume** move | ☐ |
| 5 | Switch hardware knob bank A<->B and re-check | Same CC numbers, mapped targets switch | ☐ |

## 4. Joystick behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 6 | Push joystick any direction | No effect by default (no pitch bend/mod wheel on Rytmik) | ☐ |
| 7 | Remote-override **Joystick X** to `Master_Pitch` | Joystick X now shifts master pitch | ☐ |

## 5. Keyboard behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 8 | Play any key (C3..C5) | Notes trigger Rytmik drum channels | ☐ |
| 9 | Vary velocity | Drum hit level follows velocity | ☐ |

## 6. Remote Override compatibility

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 10 | Open Remote Overrides with Rytmik selected | Knobs 1-4A/B listed | ☐ |
| 11 | Override **Knob 4 B** to `Drum_8_Reverb_Amount` | Knob 4 B sends drum 8 to reverb | ☐ |
| 12 | Override **Knob 4 A** to `Select Next Patch` | Knob 4 A cycles patches | ☐ |

## 7. Regression checklist

- [ ] Pads trigger Rytmik drum channels via drum notes (36-51)
- [ ] Pad drum notes (36-51) do not leak into the keybed; playing pads then keys leaves no stuck notes
- [ ] Knob volume changes do not retrigger channels
