# Kong Drum Designer — Test Plan

Device under test: **Akai MPK Mini Play** → **Kong Drum Designer** (`Maps/Akai/MPKMiniPlay.remotemap`)

## Control map

```
   Knob A (CC48-51)                 Knob B (CC64-67)
   1 Master Level   2 Master FX P1   1 Bus FX P1   2 Bus FX P2
   3 Master FX P2  4 Master FX On    3 Bus FX On   4 Lvl Bus FX->MFX

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : X = Pitch Bend   Y = Mod Wheel
   Keyboard : notes 48-72 (velocity)
```

## Prerequisites

- [ ] Codec deployed to `Remote/Codecs/Lua Codecs/Akai/MPKMiniPlay.lua`
- [ ] Map deployed to `Remote/Maps/Akai/MPKMiniPlay.remotemap`
- [ ] Reason open with a **Kong** as the focused/selected device
- [ ] Surface added manually in Preferences > Control Surfaces (Akai / MPK Mini Play)
- [ ] MPK keybed/knobs/joystick on MIDI channel 1, pads on MIDI channel 1 (notes per `mapping/mpk-mini-play-controls.json`)

---

## 1. Pad triggering

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 1 | Tap Bank A pads 1-8 (hardware notes 16-23) | Sent as drum notes 36-43; Kong pads 1-8 trigger | ☐ |
| 2 | Tap Bank B pads 9-16 (hardware notes 32-39) | Sent as drum notes 44-51; Kong pads 9-16 trigger | ☐ |

## 2. Knob A/B switching

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 3 | Turn **Knob 1 A** (CC48) | Kong **Master Level** moves | ☐ |
| 4 | Turn **Knob 1 B** (CC64) | Kong **Bus FX P1** moves | ☐ |
| 5 | Turn **Knob 2 A** (CC49) / **3 A** (CC50) / **4 A** (CC51) | **Master FX P1**, **Master FX P2**, **Master FX On** move | ☐ |
| 6 | Turn **Knob 2 B** (CC65) / **3 B** (CC66) / **4 B** (CC67) | **Bus FX P2**, **Bus FX On**, **Level Bus FX to Master FX** move | ☐ |
| 7 | Switch hardware knob bank A<->B and re-check | Same CC numbers, mapped targets switch | ☐ |

## 3. Joystick behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 5 | Push joystick **left/right** | Kong **pitch bends** up/down | ☐ |
| 6 | Push joystick **up/down** | Kong **modulates** (Mod Wheel) — audible tone/DAHDSR impact | ☐ |
| 7 | Release joystick | Pitch and mod return to centre/zero | ☐ |

## 4. Keyboard behaviour

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 8 | Play any key (C3..C5, notes 48-72) | Note plays through Kong selected drum/patch | ☐ |
| 9 | Vary key velocity | Velocity affects hit level | ☐ |

## 5. Device parameter response

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 10 | Move **Master Level** in Kong with mouse | **Knob 1 A** LED/position stays consistent after touch-recapture (Reason state recall) | ☐ |
| 11 | Trigger a pad in the Kong UI | Kong pad sounds; the MPK pads have no LED echo | ☐ |

## 6. Remote Override compatibility

| # | Action | Expected result | Pass |
|---|--------|-----------------|------|
| 12 | In Reason, open Remote Overrides while Kong selected | Every mapped item (Knobs 1-4A/B, Joystick X/Y) is overridable | ☐ |
| 13 | Override **Knob 4 A** to `Drum 1 Tone` | Knob 4 A now edits drum 1's tone (per-drum override) | ☐ |
| 14 | Override **Knob 4 B** to `Select Next Patch` | Knob 4 B triggers patch cycling | ☐ |

## 7. Regression checklist

- [ ] Pad drum notes (36-51) do not leak into the keybed; playing pads then keys leaves no stuck notes
- [ ] Pitch bend does not affect knobs
- [ ] Knob movement does not retrigger notes
