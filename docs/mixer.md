# Mixer 14:2 + Reason Master Section

Per-device reference for the **Akai MPK Mini Play** Reason Remote setup.

- **Device under test:** Akai MPK Mini Play -> Mixer 14:2 + Reason Master Section
- **Scope:** `Propellerheads / Mixer 14:2 + Propellerheads / Reason Master Section`
- **Map file:** `Maps/Akai/MPKMiniPlay.remotemap`

![Mixer 14:2 + Reason Master Section front panel](mixer.png)

## Control map

```
   Knob A (CC48-51)          Knob B (CC64-67)
   1-4 Channel 1-4 Level     1-4 Channel 1-4 Pan        (Mixer 14:2 scope)

   1-4 Base Ch 1-4 Level     1-4 Base Ch 1-4 Pan        (Master Section scope)

   Joystick : X = Pitch Bend (retargetable)   Y = Master Level (Mixer scope)
   Pads     : drum notes 36-51 (Bank A 36-43, Bank B 44-51)
   Keyboard : notes 48-72 (velocity)
```

## Scope

| Manufacturer | Device ID |
|--------------|-----------|
| Propellerheads | `Mixer 14:2` |
| Propellerheads | `Reason Master Section` |

## Mapping

### Propellerheads / Mixer 14:2

| Control | MIDI | Remotable item |
|---------|------|----------------|
| Knob 1 A | CC48 | Channel 1 Level |
| Knob 2 A | CC49 | Channel 2 Level |
| Knob 3 A | CC50 | Channel 3 Level |
| Knob 4 A | CC51 | Channel 4 Level |
| Knob 1 B | CC64 | Channel 1 Pan |
| Knob 2 B | CC65 | Channel 2 Pan |
| Knob 3 B | CC66 | Channel 3 Pan |
| Knob 4 B | CC67 | Channel 4 Pan |
| Joystick Y | CC16 | Master Level |

### Propellerheads / Reason Master Section

| Control | MIDI | Remotable item |
|---------|------|----------------|
| Knob 1 A | CC48 | Channel 1 Level |
| Knob 2 A | CC49 | Channel 2 Level |
| Knob 3 A | CC50 | Channel 3 Level |
| Knob 4 A | CC51 | Channel 4 Level |
| Knob 1 B | CC64 | Channel 1 Pan |
| Knob 2 B | CC65 | Channel 2 Pan |
| Knob 3 B | CC66 | Channel 3 Pan |
| Knob 4 B | CC67 | Channel 4 Pan |

Shipped commented (reserved / override templates):

| Control | MIDI | Remotable item |
|---------|------|----------------|
| Joystick Y | CC16 | Master Level |

## Details

- Contains two scopes: `Mixer 14:2` and `Reason Master Section`.
- Bank A = channel 1-4 levels; bank B = channel 1-4 pans.
- In the Mixer scope Joystick X = Pitch Bend and Joystick Y = Master Level; X/Y are left unassigned in the Master Section scope so they do not clobber device maps.
- The pads are drum-note triggers: Bank A sends notes 36-43, Bank B sends notes 44-51 (via the Keyboard item). This device ignores those notes.

## See also

- [Device documentation index](README.md)
- [Repository README](../README.md)
- [Map source](../Maps/Akai/MPKMiniPlay.remotemap)
- [Control -> MIDI matrix](../mapping/matrix.csv)
- [Capabilities](../mapping/device-capabilities.json)

