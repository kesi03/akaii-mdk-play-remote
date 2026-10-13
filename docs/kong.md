# Kong Drum Designer

Per-device reference for the **Akai MPK Mini Play** Reason Remote setup.

- **Device under test:** Akai MPK Mini Play -> Kong Drum Designer
- **Scope:** `Propellerheads / Kong Drum Designer`
- **Map file:** `Maps/Akai/MPKMiniPlay.remotemap`
- **Test plan:** [tests/kong-test.md](../tests/kong-test.md)

![Kong Drum Designer front panel](kong.png)

## Control map

```
   Knob A (CC48-51)                 Knob B (CC64-67)
   1 Master Level   2 Master FX P1   1 Bus FX P1   2 Bus FX P2
   3 Master FX P2  4 Master FX On    3 Bus FX On   4 Lvl Bus FX->MFX

   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Joystick : X = Pitch Bend   Y = Mod Wheel
   Keyboard : notes 48-72 (velocity)
```

## Scope

| Manufacturer | Device ID |
|--------------|-----------|
| Propellerheads | `Kong Drum Designer` |

## Mapping

| Control | MIDI | Remotable item |
|---------|------|----------------|
| Keyboard | Notes 48-72 | Keyboard |
| Knob 1 A | CC48 | Master Level |
| Knob 2 A | CC49 | Master FX P1 |
| Knob 3 A | CC50 | Master FX P2 |
| Knob 4 A | CC51 | Master FX On |
| Knob 1 B | CC64 | Bus FX P1 |
| Knob 2 B | CC65 | Bus FX P2 |
| Knob 3 B | CC66 | Bus FX On |
| Knob 4 B | CC67 | Level Bus FX to Master FX |
| Joystick X | Pitch Bend | Pitch Bend |
| Joystick Y | CC16 | Mod Wheel |

## Details

- Legacy device scope: `Propellerheads` / `Kong Drum Designer`.
- The pads are drum-note triggers: Bank A sends notes 36-43, Bank B sends notes 44-51 (via the Keyboard item). Kong's pads are played by the MPK pads.
- Knob bank A drives the **master** section (Master Level, Master FX P1/P2/On);
  bank B drives the **bus/FX** section (Bus FX P1/P2/On and the bus-to-master
  FX level). Per-drum editing (Drum N Tone/Decay/… ) is reachable via Remote
  Overrides.

## See also

- [Device documentation index](README.md)
- [Repository README](../README.md)
- [Map source](../Maps/Akai/MPKMiniPlay.remotemap)
- [Test plan](../tests/kong-test.md)
- [Control -> MIDI matrix](../mapping/matrix.csv)
- [Capabilities](../mapping/device-capabilities.json)

