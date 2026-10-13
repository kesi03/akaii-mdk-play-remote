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

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51); in the Drums
              category Bank A plays the GM core kit (see below)
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

## Drums category

ID8's **Drums** category is General MIDI mapped. This scope binds ID8's
`Category Name` remote item onto the surface's `ID8 Category` text item; the
codec reads it and, whenever the category is Drums, converts the Bank A pads
from their raw pad notes (16-23) to a GM core kit. Any other category keeps the
default chromatic notes (`35 + pad`).

| Pad | Raw note | Default (non-Drums) | Drums category (General MIDI) |
|-----|----------|---------------------|-------------------------------|
| 1 | 16 | 36 | 36 Bass Drum 1 (kick) |
| 2 | 17 | 37 | 38 Acoustic Snare |
| 3 | 18 | 38 | 42 Closed Hi-Hat |
| 4 | 19 | 39 | 46 Open Hi-Hat |
| 5 | 20 | 40 | 49 Crash Cymbal 1 |
| 6 | 21 | 41 | 51 Ride Cymbal 1 |
| 7 | 22 | 42 | 50 High Tom |
| 8 | 23 | 43 | 45 Low Tom |

Bank B pads are unchanged. Edit the codec's `gId8DrumNotes` table to change the
kit.

## Details

- Legacy device scope: `Propellerheads` / `ID8 Instrument Device`.
- Only Volume, Parameter 1 and Parameter 2 are exposed as knobs.
- The pads are drum-note triggers: Bank A sends notes 36-43, Bank B sends notes 44-51 (via the Keyboard item). In the instrument categories ID8 ignores those notes.
- In the **Drums** category the Bank A pads are converted to a General MIDI core kit (see [Drums category](#drums-category)); the codec detects the category from ID8's `Category Name`.

## See also

- [Device documentation index](README.md)
- [Repository README](../README.md)
- [Map source](../Maps/Akai/MPKMiniPlay.remotemap)
- [Test plan](../tests/id8-test.md)
- [Control -> MIDI matrix](../mapping/matrix.csv)
- [Capabilities](../mapping/device-capabilities.json)

