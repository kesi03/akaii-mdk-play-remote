# Dr. Octo Rex Loop Player

Per-device reference for the **Akai MPK Mini Play** Reason Remote setup.

- **Device under test:** Akai MPK Mini Play -> Dr. Octo Rex Loop Player
- **Scope:** `Propellerheads / Dr.REX Loop Player`
- **Map file:** `Maps/Akai/MPKMiniPlay.remotemap`
- **Test plan:** [tests/dr-octo-rex-test.md](../tests/dr-octo-rex-test.md)

![Dr. Octo Rex Loop Player front panel](dr-octo-rex.png)

## Control map

```
   Knob A (CC48-51)             Knob B (CC64-67)
   1 Master Level    2 Transpose     1 LFO1 Amount   2 Filter Mode
   3 Loop Transpose  4 Loop Level    3 LFO1 Wave     4 LFO1 Dest

   Pads     : Bank A pads 1-8 = Select Loop 1-8
              Bank B pad 1    = Run
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
| Pad 1 (Bank A) | Note 16 | Select Loop 1 |
| Pad 2 (Bank A) | Note 17 | Select Loop 2 |
| Pad 3 (Bank A) | Note 18 | Select Loop 3 |
| Pad 4 (Bank A) | Note 19 | Select Loop 4 |
| Pad 5 (Bank A) | Note 20 | Select Loop 5 |
| Pad 6 (Bank A) | Note 21 | Select Loop 6 |
| Pad 7 (Bank A) | Note 22 | Select Loop 7 |
| Pad 8 (Bank A) | Note 23 | Select Loop 8 |
| Pad 9 (Bank B pad 1) | Note 32 | Run |
| Pad 10-16 (Bank B pads 2-8) | Notes 33-39 | — (unassigned) |
| Knob 1 A | CC48 | Master Level |
| Knob 2 A | CC49 | Transpose |
| Knob 3 A | CC50 | Loop Transpose |
| Knob 4 A | CC51 | Loop Level |
| Knob 1 B | CC64 | LFO1 Amount |
| Knob 2 B | CC65 | Filter Mode |
| Knob 3 B | CC66 | LFO1 Wave |
| Knob 4 B | CC67 | LFO1 Dest |
| Joystick X | Pitch Bend | Pitch Bend |
| Joystick Y | CC16 | Mod Wheel |

## How the pads work on Dr. Octo Rex

The MPK pads are normally **drum-note triggers** (the codec re-emits them as
Keyboard notes 36-51 so Kong/Redrum play them). Dr. Octo Rex is the exception:
its pads **select loops / toggle Run** and must **not** also play a note. The
codec handles this with a device-aware switch (`gSuppressPadNotes`).

```
  Bank A pad N                          Bank B pad 1
  MIDI note 15+N (ch1)                  MIDI note 32 (ch1)
        |                                     |
        +------------------+------------------+
                           v
   +-----------------------------------------------------------+
   |  Lua codec  remote_set_state()                            |
   |    reads _Scope  ->  "Dr. Octo Rex"                        |
   |    "Dr. Octo Rex" is listed in gSuppressPadNotes           |
   +-----------------------------------------------------------+
                           |
                           v
   +-----------------------------------------------------------+
   |  remote_process_midi()  (pad note recognised)             |
   |                                                           |
   |    emit Pad item  (index 3 + N - 1)  ---------------+     |
   |                                                     |     |
   |    re-emit drum note 36-51  ......... SKIPPED ------+     |
   |      (suppressed for this scope)                          |
   +-----------------------------------------------------------+
                           |
                           v
   +-----------------------------------------------------------+
   |  .remotemap   Scope  Propellerheads / Dr.REX Loop Player  |
   |                                                           |
   |    Map Pad 1..Pad 8  ->  Select Loop 1..Select Loop 8     |
   |    Map Pad 9         ->  Run                              |
   +-----------------------------------------------------------+
                           |
                           v
   +-----------------------------------------------------------+
   |  Dr. Octo Rex                                             |
   |    Bank A pad 1-8  ->  load/select loops 1-8              |
   |    Bank B pad 1    ->  toggle Run                         |
   |    no note is played                                      |
   +-----------------------------------------------------------+
```

Pad -> action shorthand:

```
   Bank A                     Bank B
   +------+----------+        +------+----------+
   | Pad  | Action   |        | Pad  | Action   |
   +------+----------+        +------+----------+
   |  1   | Loop 1   |        |  1   | Run      |
   |  2   | Loop 2   |        |  2   | -        |
   |  3   | Loop 3   |        |  3   | -        |
   |  4   | Loop 4   |        |  4   | -        |
   |  5   | Loop 5   |        |  5   | -        |
   |  6   | Loop 6   |        |  6   | -        |
   |  7   | Loop 7   |        |  7   | -        |
   |  8   | Loop 8   |        |  8   | -        |
   +------+----------+        +------+----------+
```

## Details

- Keeps the legacy device ID `Dr.REX Loop Player` for backwards compatibility;
  Reason still shows the device as "Dr. Octo Rex".
- **Knob bank A** = main controls: `Master Level` (output volume),
  `Transpose` (global), `Loop Transpose`, `Loop Level`.
  **Knob bank B** = LFO shaping: amount / filter mode / wave / destination.
- **Pads** are mapped per device: Bank A pads 1-8 select loops 1-8, Bank B
  pad 1 toggles `Run`. The MPK pads are the exception to the device-agnostic
  drum-note scheme (see [How the pads work](#how-the-pads-work-on-dr-octo-rex)).
- The drum-note re-emission is suppressed for this scope so pads do not also
  play notes. This is controlled inside the codec:

  ```lua
  -- Codecs/Lua Codecs/Akai/MPKMiniPlay.lua
  gSuppressPadNotes = {
      ["Dr. Octo Rex"] = true,   -- pads do Select Loop / Run, no notes
  }
  ```

  Add another scope name (e.g. `["Redrum"] = true`) to stop its pads playing
  notes too; remove a line to restore the default drum-note behaviour.

## See also

- [Device documentation index](README.md)
- [Repository README](../README.md)
- [Map source](../Maps/Akai/MPKMiniPlay.remotemap)
- [Test plan](../tests/dr-octo-rex-test.md)
- [Control -> MIDI matrix](../mapping/matrix.csv)
- [Capabilities](../mapping/device-capabilities.json)
