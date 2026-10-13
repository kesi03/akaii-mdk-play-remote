# Drum Sequencer

Per-device reference for the **Akai MPK Mini Play** Reason Remote setup.

- **Device under test:** Akai MPK Mini Play -> Drum Sequencer (Player)
- **Scope:** `Propellerhead Software / se.propellerheads.DrumSeq`
- **Map file:** `Maps/Akai/MPKMiniPlay.remotemap`
- **Test plan:** [tests/drum-sequencer-test.md](../tests/drum-sequencer-test.md)

## Control map

```
   Knob A (CC48-51)             Knob B (CC64-67)
   (unmapped on this scope)     (unmapped on this scope)

   Pads     : Bank A pads 1-8  = Pattern 1-8 (Pattern Select 0-7)
              Bank B pad  1    = Record (toggle)
              Bank B pad  2    = Play (toggle)
              Bank B pad  3    = unassigned here (Combinator: Bypass All FX)
              Bank B pad  5    = unassigned here (Combinator: Enabled)
   Joystick : X = Pitch Bend   Y = Mod Wheel
   Keyboard : notes 48-72 (plays through the player to the instrument below)
```

## Scope

| Manufacturer | Device ID |
|--------------|-----------|
| Propellerhead Software | `se.propellerheads.DrumSeq` |

The Drum Sequencer is a Rack Extension **Player**, so its Scope lives under the
`Propellerhead Software` manufacturer (like Europa / Grain), not the built-in
`Propellerheads` manufacturer.

## Mapping

| Control | MIDI | Remotable item |
|---------|------|----------------|
| Keyboard | Notes 48-72 | Keyboard (passes through the player) |
| Pad 1 (Bank A) | Note 16 | Pattern Select = 0 (Pattern 1) |
| Pad 2 (Bank A) | Note 17 | Pattern Select = 1 (Pattern 2) |
| Pad 3 (Bank A) | Note 18 | Pattern Select = 2 (Pattern 3) |
| Pad 4 (Bank A) | Note 19 | Pattern Select = 3 (Pattern 4) |
| Pad 5 (Bank A) | Note 20 | Pattern Select = 4 (Pattern 5) |
| Pad 6 (Bank A) | Note 21 | Pattern Select = 5 (Pattern 6) |
| Pad 7 (Bank A) | Note 22 | Pattern Select = 6 (Pattern 7) |
| Pad 8 (Bank A) | Note 23 | Pattern Select = 7 (Pattern 8) |
| Pad 9 (Bank B pad 1) | Note 32 | Record (toggle) |
| Pad 10 (Bank B pad 2) | Note 33 | Play (toggle) |
| Pad 11 (Bank B pad 3) | Note 34 | — (Combinator scope: Bypass All FX) |
| Pad 12 (Bank B pad 4) | Note 35 | — |
| Pad 13 (Bank B pad 5) | Note 36 | — (Combinator scope: Enabled) |
| Pad 14-16 (Bank B pads 6-8) | Notes 37-39 | — (unassigned) |
| Joystick X | Pitch Bend | Pitch Bend |
| Joystick Y | CC16 | Mod Wheel |

Knobs are **not** mapped on this scope: the Drum Sequencer's most useful
per-lane controls (`Key1-8`, `Mute1-8`, `Solo1-8`, `Reset/Shuffle 1-8`) are
per-step/time controls that fit better on a dedicated surface. They remain
available for Remote Overrides.

## How the pads work on the Drum Sequencer

The MPK pads are normally **drum-note triggers** (the codec re-emits them as
Keyboard notes 36-51 so Kong/Redrum play them). The Drum Sequencer is an
exception like Dr. Octo Rex: its Bank A pads **pick patterns** and its Bank B
pads **toggle Record/Play**, so the drum-note re-emission is suppressed for
this scope.

Unlike Dr. Octo Rex, whose `Select Loop 1-8` items are eight separate buttons,
the Drum Sequencer has a **single** `Pattern Select` remote item (range -1..7,
where 0 = Pattern 1). All eight Bank A pads therefore map to `Pattern Select`,
and the codec sends a **different value per pad** (`padNumber - 1`):

```
  Bank A pad N                          Bank B pad 1 / 2
  MIDI note 15+N (ch1)                  MIDI note 32 / 33 (ch1)
       |                                      |
       +------------------+-------------------+
                          v
  +-----------------------------------------------------------+
  |  Lua codec  remote_set_state()                            |
  |    reads _Scope  ->  "Drum Sequencer"                     |
  |    listed in gSuppressPadNotes      (no drum notes)       |
  |    listed in gPatternValueScopes    (Pad N -> value N-1)  |
  +-----------------------------------------------------------+
                          |
                          v
  +-----------------------------------------------------------+
  |  remote_process_midi()  (pad note recognised)             |
  |    emit Pad item  value = N-1 (Bank A)  ------------+     |
  |    emit Pad item  value = 1/0 (Bank B, buttons)     |     |
  |    re-emit drum note 36-51  ....... SKIPPED --------+     |
  +-----------------------------------------------------------+
                          |
                          v
  +-----------------------------------------------------------+
  |  .remotemap  Scope  Propellerhead Software / DrumSeq      |
  |    Map Pad 1..Pad 8  ->  Pattern Select                   |
  |    Map Pad 9         ->  Record                           |
  |    Map Pad 10        ->  Play                             |
  +-----------------------------------------------------------+
                          |
                          v
  +-----------------------------------------------------------+
  |  Drum Sequencer                                           |
  |    Bank A pad 1-8  ->  Pattern 1-8                        |
  |    Bank B pad 1/2  ->  Record / Play                      |
  |    no note is played                                      |
  +-----------------------------------------------------------+
```

Pad -> action shorthand:

```
   Bank A                     Bank B
   +------+----------+        +------+---------------------+
   | Pad  | Action   |        | Pad  | Action              |
   +------+----------+        +------+---------------------+
   |  1   | Pattern 1|        |  1   | Record (toggle)     |
   |  2   | Pattern 2|        |  2   | Play (toggle)       |
   |  3   | Pattern 3|        |  3   | - (Combi bypass FX) |
   |  4   | Pattern 4|        |  4   | -                   |
   |  5   | Pattern 5|        |  5   | - (Combi enabled)   |
   |  6   | Pattern 6|        |  6   | -                   |
   |  7   | Pattern 7|        |  7   | -                   |
   |  8   | Pattern 8|        |  8   | -                   |
   +------+----------+        +------+---------------------+
```

## Details

- **Bank A = patterns.** Each pad sends `padNumber - 1` so Pad 1 selects
  Pattern 1 ... Pad 8 selects Pattern 8. The same value is sent on release as
  well, so letting a pad go does not jump the pattern back to Pattern 1.
- **Bank B = transport.** Pad 1 toggles `Record`, Pad 2 toggles `Play`. These
  are the **Drum Sequencer's own** Record/Play (device-scoped), *not* the
  global `Reason Document` transport, so they only act while a Drum Sequencer
  is focused and never collide with other devices' pad mappings.
- **Pad 11 / Pad 13** are unassigned on this scope. On the **Combinator** scope
  they map to `Bypass All FX` / `Enabled`, so a Combinator-driven live rig can
  still toggle them from Bank B pads 3 and 5.
- **No drum notes** are emitted for this scope (`gSuppressPadNotes`) - the pads
  only pick patterns / toggle transport. To audition the instrument placed
  below the player, play the keybed instead.
- The suppression / pattern behaviour is controlled inside the codec:

  ```lua
  -- Codecs/Lua Codecs/Akai/MPKMiniPlay.lua
  gPatternValueScopes = {
      ["Drum Sequencer"] = true,   -- Bank A pad N -> Pattern Select value N-1
  }
  gSuppressPadNotes = {
      ["Dr. Octo Rex"] = true,
      ["Drum Sequencer"] = true,   -- pads select patterns / transport, no notes
  }
  ```

  The scope name must match the right-hand value of the scope's
  `Map _Scope "..."` line. If Reason reports a different device name, adjust
  that string and the two tables together.

## See also

- [Device documentation index](README.md)
- [Repository README](../README.md)
- [Map source](../Maps/Akai/MPKMiniPlay.remotemap)
- [Test plan](../tests/drum-sequencer-test.md)
- [Control -> MIDI matrix](../mapping/matrix.csv)
- [Capabilities](../mapping/device-capabilities.json)
