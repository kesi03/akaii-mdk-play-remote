# Rytmik Drum Machine

Per-device reference for the **Akai MPK Mini Play** Reason Remote setup.

- **Device under test:** Akai MPK Mini Play -> Rytmik Drum Machine
- **Scope:** `Propellerhead Software / se.propellerheads.DMFC`
- **Map file:** `Maps/Akai/MPKMiniPlay.remotemap`
- **Test plan:** [tests/rytmik-test.md](../tests/rytmik-test.md)

![Rytmik Drum Machine front panel](rytmik.png)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1 Drum 1 Volume   2 Drum 2 Volume   1 Drum 5 Volume   2 Drum 6 Volume
   3 Drum 3 Volume   4 Drum 4 Volume   3 Drum 7 Volume   4 Drum 8 Volume

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : unmapped
   Keyboard : notes 48-72 (velocity)
```

## Scope

| Manufacturer | Device ID |
|--------------|-----------|
| Propellerhead Software | `se.propellerheads.DMFC` |

## Mapping

| Control | MIDI | Remotable item |
|---------|------|----------------|
| Keyboard | Notes 48-72 | Keyboard |
| Knob 1 A | CC48 | Drum_1_Volume |
| Knob 2 A | CC49 | Drum_2_Volume |
| Knob 3 A | CC50 | Drum_3_Volume |
| Knob 4 A | CC51 | Drum_4_Volume |
| Knob 1 B | CC64 | Drum_5_Volume |
| Knob 2 B | CC65 | Drum_6_Volume |
| Knob 3 B | CC66 | Drum_7_Volume |
| Knob 4 B | CC67 | Drum_8_Volume |

Shipped commented (reserved / override templates):

| Control | MIDI | Remotable item |
|---------|------|----------------|
| Joystick X | Pitch Bend | Master_Pitch |
| Joystick Y | CC16 | Master_Reverb |

## Details

- Reason Compact-derived device: scope `se.propellerheads.DMFC`, remotable names use underscores.
- The pads are drum-note triggers: Bank A sends notes 36-43, Bank B sends notes 44-51 (via the Keyboard item). Rytmik channels respond to the drum notes.
- Bank A = volumes for drums 1-4; bank B = volumes for drums 5-8.

## See also

- [Device documentation index](README.md)
- [Repository README](../README.md)
- [Map source](../Maps/Akai/MPKMiniPlay.remotemap)
- [Test plan](../tests/rytmik-test.md)
- [Control -> MIDI matrix](../mapping/matrix.csv)
- [Capabilities](../mapping/device-capabilities.json)

