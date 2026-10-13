# ID8 Instrument Device

Per-device reference for the **Akai MPK Mini Play** Reason Remote setup.

- **Device under test:** Akai MPK Mini Play -> ID8 Instrument Device
- **Scope:** `Propellerheads / ID8 Instrument Device`
- **Map file:** `Maps/Akai/MPKMiniPlay.remotemap`
- **Test plan:** [tests/id8-test.md](../tests/id8-test.md)

![ID8 Instrument Device front panel](id8.png)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1 Volume   2 Parameter 1   1 (unmapped)   2 (unmapped)
   3 Parameter 2   4 (unmapped)   3 (unmapped)   4 (unmapped)

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : unmapped
   Keyboard : notes 48-72 (velocity)
```

## Scope

| Manufacturer | Device ID |
|--------------|-----------|
| Propellerheads | `ID8 Instrument Device` |

## Mapping

| Control | MIDI | Remotable item |
|---------|------|----------------|
| Keyboard | Notes 48-72 | Keyboard |
| Knob 1 A | CC48 | Volume |
| Knob 2 A | CC49 | Parameter 1 |
| Knob 3 A | CC50 | Parameter 2 |

Shipped commented (reserved / override templates):

| Control | MIDI | Remotable item |
|---------|------|----------------|
| Joystick X | Pitch Bend | Pitch Bend |
| Joystick Y | CC16 | Mod Wheel |

## Details

- Legacy device scope: `Propellerheads` / `ID8 Instrument Device`.
- Only Volume, Parameter 1 and Parameter 2 are exposed as knobs.
- The pads are drum-note triggers: Bank A sends notes 36-43, Bank B sends notes 44-51 (via the Keyboard item). This device ignores those notes.

## See also

- [Device documentation index](README.md)
- [Repository README](../README.md)
- [Map source](../Maps/Akai/MPKMiniPlay.remotemap)
- [Test plan](../tests/id8-test.md)
- [Control -> MIDI matrix](../mapping/matrix.csv)
- [Capabilities](../mapping/device-capabilities.json)

