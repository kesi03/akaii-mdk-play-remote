# Combinator 2

Per-device reference for the **Akai MPK Mini Play** Reason Remote setup.

- **Device under test:** Akai MPK Mini Play -> Combinator 2
- **Scope:** `Propellerheads / Combinator`
- **Map file:** `Maps/Akai/MPKMiniPlay.remotemap`
- **Test plan:** [tests/combinator2-test.md](../tests/combinator2-test.md)

![Combinator 2 front panel](combinator2.png)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1 Rotary 1   2 Rotary 2   1 Enabled    2 Run Pattern Devices
   3 Rotary 3   4 Rotary 4   3 Bypass All FX  4 Select Patch Delta

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : X = Pitch Bend   Y = Mod Wheel
   Keyboard : notes 48-72 (velocity)
```

## Scope

| Manufacturer | Device ID |
|--------------|-----------|
| Propellerheads | `Combinator` |

## Mapping

| Control | MIDI | Remotable item |
|---------|------|----------------|
| Keyboard | Notes 48-72 | Keyboard |
| Knob 1 A | CC48 | Rotary 1 |
| Knob 2 A | CC49 | Rotary 2 |
| Knob 3 A | CC50 | Rotary 3 |
| Knob 4 A | CC51 | Rotary 4 |
| Knob 1 B | CC64 | Enabled |
| Knob 2 B | CC65 | Run Pattern Devices |
| Knob 3 B | CC66 | Bypass All FX |
| Knob 4 B | CC67 | Select Patch Delta |
| Joystick X | Pitch Bend | Pitch Bend |
| Joystick Y | CC16 | Mod Wheel |

## Details

- Legacy device scope: `Propellerheads` / `Combinator`.
- Bank A = rotaries 1-4; bank B = global controls (Enabled, Run Pattern Devices, Bypass All FX, Select Patch Delta).
- The pads are drum-note triggers: Bank A sends notes 36-43, Bank B sends notes 44-51 (via the Keyboard item). This device ignores those notes.

## See also

- [Device documentation index](README.md)
- [Repository README](../README.md)
- [Map source](../Maps/Akai/MPKMiniPlay.remotemap)
- [Test plan](../tests/combinator2-test.md)
- [Control -> MIDI matrix](../mapping/matrix.csv)
- [Capabilities](../mapping/device-capabilities.json)

