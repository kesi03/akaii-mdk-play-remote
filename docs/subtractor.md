# SubTractor Analog Synthesizer

Per-device reference for the **Akai MPK Mini Play** Reason Remote setup.

- **Device under test:** Akai MPK Mini Play -> SubTractor Analog Synthesizer
- **Scope:** `Propellerheads / SubTractor Analog Synthesizer`
- **Map file:** `Maps/Akai/MPKMiniPlay.remotemap`
- **Test plan:** [tests/subtractor-test.md](../tests/subtractor-test.md)

![SubTractor Analog Synthesizer front panel](subtractor.png)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1 Filter Freq   2 Filter Res   1 Amp Env Attack    2 Amp Env Decay
   3 Filter Env    4 LFO1 Rate    3 Amp Env Sustain   4 Amp Env Release

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : X = Pitch Bend   Y = Mod Wheel
   Keyboard : notes 48-72 (velocity)
```

## Scope

| Manufacturer | Device ID |
|--------------|-----------|
| Propellerheads | `SubTractor Analog Synthesizer` |

## Mapping

| Control | MIDI | Remotable item |
|---------|------|----------------|
| Keyboard | Notes 48-72 | Keyboard |
| Knob 1 A | CC48 | Filter Freq |
| Knob 2 A | CC49 | Filter Res |
| Knob 3 A | CC50 | Filter Env Amount |
| Knob 4 A | CC51 | LFO1 Rate |
| Knob 1 B | CC64 | Amp Env Attack |
| Knob 2 B | CC65 | Amp Env Decay |
| Knob 3 B | CC66 | Amp Env Sustain |
| Knob 4 B | CC67 | Amp Env Release |
| Joystick X | Pitch Bend | Pitch Bend |
| Joystick Y | CC16 | Mod Wheel |

## Details

- Legacy device scope: `Propellerheads` / `SubTractor Analog Synthesizer`.
- Bank A = filter + LFO1 rate; bank B = amp envelope.
- The pads are drum-note triggers: Bank A sends notes 36-43, Bank B sends notes 44-51 (via the Keyboard item). This device ignores those notes.

## See also

- [Device documentation index](README.md)
- [Repository README](../README.md)
- [Map source](../Maps/Akai/MPKMiniPlay.remotemap)
- [Test plan](../tests/subtractor-test.md)
- [Control -> MIDI matrix](../mapping/matrix.csv)
- [Capabilities](../mapping/device-capabilities.json)

