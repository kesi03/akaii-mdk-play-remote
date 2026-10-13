# Redrum Drum Computer

Per-device reference for the **Akai MPK Mini Play** Reason Remote setup.

- **Device under test:** Akai MPK Mini Play -> Redrum Drum Computer
- **Scope:** `Propellerheads / Redrum Drum Computer`
- **Map file:** `Maps/Akai/MPKMiniPlay.remotemap`
- **Test plan:** [tests/redrum-test.md](../tests/redrum-test.md)

![Redrum Drum Computer front panel](redrum.png)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1 Drum 1 Level   2 Drum 2 Level   1 Drum 1 Pan   2 Drum 2 Pan
   3 Drum 3 Level   4 Drum 4 Level   3 Drum 3 Pan   4 Drum 4 Pan

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : unmapped
   Keyboard : notes 48-72 (velocity)
```

## Scope

| Manufacturer | Device ID |
|--------------|-----------|
| Propellerheads | `Redrum Drum Computer` |

## Mapping

| Control | MIDI | Remotable item |
|---------|------|----------------|
| Keyboard | Notes 48-72 | Keyboard |
| Knob 1 A | CC48 | Drum 1 Level |
| Knob 2 A | CC49 | Drum 2 Level |
| Knob 3 A | CC50 | Drum 3 Level |
| Knob 4 A | CC51 | Drum 4 Level |
| Knob 1 B | CC64 | Drum 1 Pan |
| Knob 2 B | CC65 | Drum 2 Pan |
| Knob 3 B | CC66 | Drum 3 Pan |
| Knob 4 B | CC67 | Drum 4 Pan |

Shipped commented (reserved / override templates):

| Control | MIDI | Remotable item |
|---------|------|----------------|
| Joystick X | Pitch Bend | Pitch Bend |
| Joystick Y | CC16 | Mod Wheel |

## Details

- Legacy device scope: `Propellerheads` / `Redrum Drum Computer`.
- The pads are drum-note triggers: Bank A sends notes 36-43, Bank B sends notes 44-51 (via the Keyboard item). Redrum is note-triggered from 36-51, so the MPK pads play its drums.
- Knob bank A = drum 1-4 levels; bank B = drum 1-4 pans.

## See also

- [Device documentation index](README.md)
- [Repository README](../README.md)
- [Map source](../Maps/Akai/MPKMiniPlay.remotemap)
- [Test plan](../tests/redrum-test.md)
- [Control -> MIDI matrix](../mapping/matrix.csv)
- [Capabilities](../mapping/device-capabilities.json)

