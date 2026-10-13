# Dr. Octo Rex Loop Player

Per-device reference for the **Akai MPK Mini Play** Reason Remote setup.

- **Device under test:** Akai MPK Mini Play -> Dr. Octo Rex Loop Player
- **Scope:** `Propellerheads / Dr.REX Loop Player`
- **Map file:** `Maps/Akai/MPKMiniPlay.remotemap`
- **Test plan:** [tests/dr-octo-rex-test.md](../tests/dr-octo-rex-test.md)

![Dr. Octo Rex Loop Player front panel](dr-octo-rex.png)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1 Filter Freq   2 Filter Res   1 LFO1 Amount   2 Filter Mode
   3 Filter Env    4 LFO1 Rate    3 LFO1 Wave     4 LFO1 Dest

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : X = Pitch Bend   Y = Mod Wheel
   Keyboard : notes 48-72 (velocity)
```

## Scope

| Manufacturer | Device ID |
|--------------|-----------|
| Propellerheads | `Dr.REX Loop Player` |

## Mapping

| Control | MIDI | Remotable item |
|---------|------|----------------|
| Keyboard | Notes 48-72 | Keyboard |
| Knob 1 A | CC48 | Filter Freq |
| Knob 2 A | CC49 | Filter Res |
| Knob 3 A | CC50 | Filter Env Amount |
| Knob 4 A | CC51 | LFO1 Rate |
| Knob 1 B | CC64 | LFO1 Amount |
| Knob 2 B | CC65 | Filter Mode |
| Knob 3 B | CC66 | LFO1 Wave |
| Knob 4 B | CC67 | LFO1 Dest |
| Joystick X | Pitch Bend | Pitch Bend |
| Joystick Y | CC16 | Mod Wheel |

## Details

- Keeps the legacy device ID `Dr.REX Loop Player` for backwards compatibility; Reason still shows the device as "Dr. Octo Rex".
- Knob bank A = filter + LFO rate; bank B = LFO amount/mode/wave/destination.
- The pads are drum-note triggers: Bank A sends notes 36-43, Bank B sends notes 44-51 (via the Keyboard item). This device ignores those notes.

## See also

- [Device documentation index](README.md)
- [Repository README](../README.md)
- [Map source](../Maps/Akai/MPKMiniPlay.remotemap)
- [Test plan](../tests/dr-octo-rex-test.md)
- [Control -> MIDI matrix](../mapping/matrix.csv)
- [Capabilities](../mapping/device-capabilities.json)

