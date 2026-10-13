# Grain Sample Manipulator

Per-device reference for the **Akai MPK Mini Play** Reason Remote setup.

- **Device under test:** Akai MPK Mini Play -> Grain Sample Manipulator
- **Scope:** `Propellerhead Software / se.propellerheads.Grain`
- **Map file:** `Maps/Akai/MPKMiniPlay.remotemap`
- **Test plan:** [tests/grain-test.md](../tests/grain-test.md)

![Grain Sample Manipulator front panel](grain.png)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1 Sample Level   2 Osc Level     1 Amp Attack    2 Amp Decay
   3 Filter Freq    4 Filter Reso   3 Amp Sustain   4 Amp Release

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : X = Pitch Bend   Y = Mod Wheel
   Keyboard : notes 48-72 (velocity)
```

## Scope

| Manufacturer | Device ID |
|--------------|-----------|
| Propellerhead Software | `se.propellerheads.Grain` |

## Mapping

| Control | MIDI | Remotable item |
|---------|------|----------------|
| Keyboard | Notes 48-72 | Keyboard |
| Knob 1 A | CC48 | Sample Level |
| Knob 2 A | CC49 | Osc Level |
| Knob 3 A | CC50 | Filter Freq |
| Knob 4 A | CC51 | Filter Reso |
| Knob 1 B | CC64 | Amp Attack |
| Knob 2 B | CC65 | Amp Decay |
| Knob 3 B | CC66 | Amp Sustain |
| Knob 4 B | CC67 | Amp Release |
| Joystick X | Pitch Bend | Pitch Bend |
| Joystick Y | CC16 | Mod Wheel |

## Details

- Modern scope: `Propellerhead Software` / `se.propellerheads.Grain`.
- Bank A = sample/osc levels + filter; bank B = amp envelope.

## See also

- [Device documentation index](README.md)
- [Repository README](../README.md)
- [Map source](../Maps/Akai/MPKMiniPlay.remotemap)
- [Test plan](../tests/grain-test.md)
- [Control -> MIDI matrix](../mapping/matrix.csv)
- [Capabilities](../mapping/device-capabilities.json)

