# Malstrom Graintable Synthesizer

Per-device reference for the **Akai MPK Mini Play** Reason Remote setup.

- **Device under test:** Akai MPK Mini Play -> Malstrom Graintable Synthesizer
- **Scope:** `Propellerheads / Malstrom Graintable Synthesizer`
- **Map file:** `Maps/Akai/MPKMiniPlay.remotemap`
- **Test plan:** [tests/malstrom-test.md](../tests/malstrom-test.md)

![Malstrom Graintable Synthesizer front panel](malstrom.png)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1 Filter A Freq   2 Filter A Res   1 Modulator A Rate    2 Modulator B Rate
   3 Filter B Freq   4 Filter B Res   3 Oscillator A Motion 4 Oscillator B Motion

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : X = Pitch Bend   Y = Mod Wheel
   Keyboard : notes 48-72 (velocity)
```

## Scope

| Manufacturer | Device ID |
|--------------|-----------|
| Propellerheads | `Malstrom Graintable Synthesizer` |

## Mapping

| Control | MIDI | Remotable item |
|---------|------|----------------|
| Keyboard | Notes 48-72 | Keyboard |
| Knob 1 A | CC48 | Filter A Freq |
| Knob 2 A | CC49 | Filter A Resonance |
| Knob 3 A | CC50 | Filter B Freq |
| Knob 4 A | CC51 | Filter B Resonance |
| Knob 1 B | CC64 | Modulator A Rate |
| Knob 2 B | CC65 | Modulator B Rate |
| Knob 3 B | CC66 | Oscillator A Motion |
| Knob 4 B | CC67 | Oscillator B Motion |
| Joystick X | Pitch Bend | Pitch Bend |
| Joystick Y | CC16 | Mod Wheel |

## Details

- Legacy device scope: `Propellerheads` / `Malstrom Graintable Synthesizer`.
- Bank A = filter A/B freq + resonance; bank B = modulator rates + oscillator motion.
- The pads are drum-note triggers: Bank A sends notes 36-43, Bank B sends notes 44-51 (via the Keyboard item). This device ignores those notes.

## See also

- [Device documentation index](README.md)
- [Repository README](../README.md)
- [Map source](../Maps/Akai/MPKMiniPlay.remotemap)
- [Test plan](../tests/malstrom-test.md)
- [Control -> MIDI matrix](../mapping/matrix.csv)
- [Capabilities](../mapping/device-capabilities.json)

