# Radical Piano

Per-device reference for the **Akai MPK Mini Play** Reason Remote setup.

- **Device under test:** Akai MPK Mini Play -> Radical Piano
- **Scope:** `Propellerhead Software / se.propellerheads.radicalpiano`
- **Map file:** `Maps/Akai/MPKMiniPlay.remotemap`
- **Test plan:** [tests/radical-piano-test.md](../tests/radical-piano-test.md)

![Radical Piano front panel](radical-piano.png)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1 Character            2 Microphone 1 Type   1 Env Attack   2 Env Decay Curve
   3 Mic/Instrument Blend 4 Microphone 2 Type   3 Env Release  4 Master Volume

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : X = Pitch Bend   (Y unmapped; no Mod Wheel remotable)
   Keyboard : notes 48-72 (velocity)
```

## Scope

| Manufacturer | Device ID |
|--------------|-----------|
| Propellerhead Software | `se.propellerheads.radicalpiano` |

## Mapping

| Control | MIDI | Remotable item |
|---------|------|----------------|
| Keyboard | Notes 48-72 | Keyboard |
| Knob 1 A | CC48 | Character |
| Knob 2 A | CC49 | Microphone 1 Type |
| Knob 3 A | CC50 | Microphone and Instrument Blend |
| Knob 4 A | CC51 | Microphone 2 Type |
| Knob 1 B | CC64 | Env Attack |
| Knob 2 B | CC65 | Env Decay Curve |
| Knob 3 B | CC66 | Env Release |
| Knob 4 B | CC67 | Master Volume |
| Joystick X | Pitch Bend | Pitch Bend |

Shipped commented (reserved / override templates):

| Control | MIDI | Remotable item |
|---------|------|----------------|
| Joystick Y | CC16 | Character |

## Details

- Lowercase device ID: `se.propellerheads.radicalpiano`.
- Responds to Pitch Bend but exposes no Mod Wheel, so Joystick Y ships commented and is re-pointed via Remote Overrides.
- Bank A = character + microphones/blend; bank B = env + master volume.
- The pads are drum-note triggers: Bank A sends notes 36-43, Bank B sends notes 44-51 (via the Keyboard item). This device ignores those notes.

## See also

- [Device documentation index](README.md)
- [Repository README](../README.md)
- [Map source](../Maps/Akai/MPKMiniPlay.remotemap)
- [Test plan](../tests/radical-piano-test.md)
- [Control -> MIDI matrix](../mapping/matrix.csv)
- [Capabilities](../mapping/device-capabilities.json)

