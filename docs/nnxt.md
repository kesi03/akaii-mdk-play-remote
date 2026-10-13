# NN-XT Advanced Sampler

Per-device reference for the **Akai MPK Mini Play** Reason Remote setup.

- **Device under test:** Akai MPK Mini Play -> NN-XT Advanced Sampler
- **Scope:** `Propellerheads / NN-XT Advanced Sampler`
- **Map file:** `Maps/Akai/MPKMiniPlay.remotemap`
- **Test plan:** [tests/nnxt-test.md](../tests/nnxt-test.md)

![NN-XT Advanced Sampler front panel](nnxt.png)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1 Filter Freq     2 Filter Res       1 Amp Env Release     2 Mod Env Decay
   3 Amp Env Attack  4 Amp Env Decay    3 External Controller 4 Master Volume

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : X = Pitch Bend   Y = Mod Wheel
   Keyboard : notes 48-72 (velocity)
```

## Scope

| Manufacturer | Device ID |
|--------------|-----------|
| Propellerheads | `NN-XT Advanced Sampler` |

## Mapping

| Control | MIDI | Remotable item |
|---------|------|----------------|
| Keyboard | Notes 48-72 | Keyboard |
| Knob 1 A | CC48 | Filter Freq |
| Knob 2 A | CC49 | Filter Res |
| Knob 3 A | CC50 | Amp Env Attack |
| Knob 4 A | CC51 | Amp Env Decay |
| Knob 1 B | CC64 | Amp Env Release |
| Knob 2 B | CC65 | Mod Env Decay |
| Knob 3 B | CC66 | External Controller |
| Knob 4 B | CC67 | Master Volume |
| Joystick X | Pitch Bend | Pitch Bend |
| Joystick Y | CC16 | Mod Wheel |

## Details

- Legacy device scope: `Propellerheads` / `NN-XT Advanced Sampler`.
- Bank A = filter + amp env attack/decay; bank B = env release, mod env, external controller, master volume.
- The pads are drum-note triggers: Bank A sends notes 36-43, Bank B sends notes 44-51 (via the Keyboard item). This device ignores those notes.

## See also

- [Device documentation index](README.md)
- [Repository README](../README.md)
- [Map source](../Maps/Akai/MPKMiniPlay.remotemap)
- [Test plan](../tests/nnxt-test.md)
- [Control -> MIDI matrix](../mapping/matrix.csv)
- [Capabilities](../mapping/device-capabilities.json)

