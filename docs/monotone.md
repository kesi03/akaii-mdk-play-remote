# Monotone Bass Synthesizer

Per-device reference for the **Akai MPK Mini Play** Reason Remote setup.

- **Device under test:** Akai MPK Mini Play -> Monotone Bass Synthesizer
- **Scope:** `Propellerhead Software / se.propellerheads.Monotone`
- **Map file:** `Maps/Akai/MPKMiniPlay.remotemap`
- **Test plan:** [tests/monotone-test.md](../tests/monotone-test.md)

![Monotone Bass Synthesizer front panel](monotone.png)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1 Osc Mix     2 Filter Freq   1 Amp Attack    2 Amp Decay
   3 Filter Reso 4 Filter Vel    3 Amp Sustain   4 Amp Release

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : X = Pitch Bend   Y = Mod Wheel
   Keyboard : notes 48-72 (velocity)
```

## Scope

| Manufacturer | Device ID |
|--------------|-----------|
| Propellerhead Software | `se.propellerheads.Monotone` |

## Mapping

| Control | MIDI | Remotable item |
|---------|------|----------------|
| Keyboard | Notes 48-72 | Keyboard |
| Knob 1 A | CC48 | Osc Mix |
| Knob 2 A | CC49 | Filter Freq |
| Knob 3 A | CC50 | Filter Reso |
| Knob 4 A | CC51 | Filter Vel |
| Knob 1 B | CC64 | Amp Attack |
| Knob 2 B | CC65 | Amp Decay |
| Knob 3 B | CC66 | Amp Sustain |
| Knob 4 B | CC67 | Amp Release |
| Joystick X | Pitch Bend | Pitch Bend |
| Joystick Y | CC16 | Mod Wheel |

## Details

- Modern scope: `Propellerhead Software` / `se.propellerheads.Monotone`.
- Bank A = osc mix + filter; bank B = amp envelope.
- The pads are drum-note triggers: Bank A sends notes 36-43, Bank B sends notes 44-51 (via the Keyboard item). This device ignores those notes.

## See also

- [Device documentation index](README.md)
- [Repository README](../README.md)
- [Map source](../Maps/Akai/MPKMiniPlay.remotemap)
- [Test plan](../tests/monotone-test.md)
- [Control -> MIDI matrix](../mapping/matrix.csv)
- [Capabilities](../mapping/device-capabilities.json)

