discard """
--- Day 6: Guard Gallivant ---
The Historians use their fancy device again, this time to whisk you all away to the North Pole prototype suit manufacturing lab... in the year 1518! It turns out that having direct access to history is very convenient for a group of historians.

You still have to be careful of time paradoxes, and so it will be important to avoid anyone from 1518 while The Historians search for the Chief. Unfortunately, a single guard is patrolling this part of the lab.

Maybe you can work out where the guard will go ahead of time so that The Historians can search safely?

You start by making a map (your puzzle input) of the situation. For example:

....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...
The map shows the current position of the guard with ^ (to indicate the guard is currently facing up from the perspective of the map). Any obstructions - crates, desks, alchemical reactors, etc. - are shown as #.

Lab guards in 1518 follow a very strict patrol protocol which involves repeatedly following these steps:

If there is something directly in front of you, turn right 90 degrees.
Otherwise, take a step forward.
Following the above protocol, the guard moves up several times until she reaches an obstacle (in this case, a pile of failed suit prototypes):

....#.....
....^....#
..........
..#.......
.......#..
..........
.#........
........#.
#.........
......#...
Because there is now an obstacle in front of the guard, she turns right before continuing straight in her new facing direction:

....#.....
........>#
..........
..#.......
.......#..
..........
.#........
........#.
#.........
......#...
Reaching another obstacle (a spool of several very long polymers), she turns right again and continues downward:

....#.....
.........#
..........
..#.......
.......#..
..........
.#......v.
........#.
#.........
......#...
This process continues for a while, but the guard eventually leaves the mapped area (after walking past a tank of universal solvent):

....#.....
.........#
..........
..#.......
.......#..
..........
.#........
........#.
#.........
......#v..
By predicting the guard's route, you can determine which specific positions in the lab will be in the patrol path. Including the guard's starting position, the positions visited by the guard before leaving the area are marked with an X:

....#.....
....XXXXX#
....X...X.
..#.X...X.
..XXXXX#X.
..X.X.X.X.
.#XXXXXXX.
.XXXXXXX#.
#XXXXXXX..
......#X..
In this example, the guard will visit 41 distinct positions on your map.

Predict the path of the guard. How many distinct positions will the guard visit before leaving the mapped area?

Your puzzle answer was 5145.

--- Part Two ---
While The Historians begin working around the guard's patrol route, you borrow their fancy device and step outside the lab. From the safety of a supply closet, you time travel through the last few months and record the nightly status of the lab's guard post on the walls of the closet.

Returning after what seems like only a few seconds to The Historians, they explain that the guard's patrol area is simply too large for them to safely search the lab without getting caught.

Fortunately, they are pretty sure that adding a single new obstruction won't cause a time paradox. They'd like to place the new obstruction in such a way that the guard will get stuck in a loop, making the rest of the lab safe to search.

To have the lowest chance of creating a time paradox, The Historians would like to know all of the possible positions for such an obstruction. The new obstruction can't be placed at the guard's starting position - the guard is there right now and would notice.

In the above example, there are only 6 different positions where a new obstruction would cause the guard to get stuck in a loop. The diagrams of these six situations use O to mark the new obstruction, | to show a position where the guard moves up/down, - to show a position where the guard moves left/right, and + to show a position where the guard moves both up/down and left/right.

Option one, put a printing press next to the guard's starting position:

....#.....
....+---+#
....|...|.
..#.|...|.
....|..#|.
....|...|.
.#.O^---+.
........#.
#.........
......#...
Option two, put a stack of failed suit prototypes in the bottom right quadrant of the mapped area:


....#.....
....+---+#
....|...|.
..#.|...|.
..+-+-+#|.
..|.|.|.|.
.#+-^-+-+.
......O.#.
#.........
......#...
Option three, put a crate of chimney-squeeze prototype fabric next to the standing desk in the bottom right quadrant:

....#.....
....+---+#
....|...|.
..#.|...|.
..+-+-+#|.
..|.|.|.|.
.#+-^-+-+.
.+----+O#.
#+----+...
......#...
Option four, put an alchemical retroencabulator near the bottom left corner:

....#.....
....+---+#
....|...|.
..#.|...|.
..+-+-+#|.
..|.|.|.|.
.#+-^-+-+.
..|...|.#.
#O+---+...
......#...
Option five, put the alchemical retroencabulator a bit to the right instead:

....#.....
....+---+#
....|...|.
..#.|...|.
..+-+-+#|.
..|.|.|.|.
.#+-^-+-+.
....|.|.#.
#..O+-+...
......#...
Option six, put a tank of sovereign glue right next to the tank of universal solvent:

....#.....
....+---+#
....|...|.
..#.|...|.
..+-+-+#|.
..|.|.|.|.
.#+-^-+-+.
.+----++#.
#+----++..
......#O..
It doesn't really matter what you choose to use as an obstacle so long as you and The Historians can put it into position without the guard noticing. The important thing is having enough options that you can find one that minimizes time paradoxes, and in this example, there are 6 different positions you could choose.

You need to get the guard stuck in a loop by adding a single new obstruction. How many different positions could you choose for this obstruction?

Your puzzle answer was 1523.
"""
import std/[strutils, sequtils, algorithm, sets, hashes]
import aoc_utils
#import nimprof

#Position is bigger Row == Down, bigger Column == Right
# These correspond to Up, Right, Left, Down TODO: ENUM
const directions = @[(-1, 0), (0, 1), (1, 0), (0, -1)]
type Pos = (int, int)
type PosWithDirection = (Pos, int)
var max: Pos
var artifacts = initHashSet[Pos](100)

proc hash(x: Pos): Hash =
  ## Computes a Hash from `x`.
  cast[Hash](x[0] * (max[0]) + x[1])

proc hash(x: PosWithDirection): Hash =
  ## Computes a Hash from `x`.
  cast[Hash]((x[0][0] * (max[0]) + x[0][1] + (x[1] * max[0] * max[1])))

func `+`(x, y: Pos): Pos =
  (x[0] + y[0], x[1] + y[1])

proc inbounds(max: Pos, current: Pos): bool =
  if current[0] < 0 or current[0] == max[0] or current[1] < 0 or current[1] == max[1]:
    return false
  return true

proc isLoop(start: Pos, extra_value: (int, int) = (-1, -1)): bool =
  var visited = initHashSet[PosWithDirection](10000)
  var pos = start
  var bearing = 0
  while max.inbounds(pos):
    var next_pos: Pos = pos + directions[bearing]
    if artifacts.contains(next_pos) or next_pos == extra_value:
      bearing = (bearing + 1) mod 4
      continue
    let posDir: PosWithDirection = (pos, bearing)
    if visited.containsOrIncl(posDir):
      return true
    pos = next_pos
  false

proc getVisited(start: Pos): seq[Pos] =
  var visited = initHashSet[Pos](10000)
  var pos = start
  var bearing = 0
  while max.inbounds(pos):
    var next_pos: Pos = pos + directions[bearing]
    if artifacts.contains(next_pos):
      bearing = (bearing + 1) mod 4
      continue
    visited.incl(pos)
    pos = next_pos
  return sorted(visited.items.toSeq()).deduplicate(true)

proc day_06*(): Solution =
  var start_guard_Position: Pos
  var charMap = getInput().splitlines.mapIt(cast[seq[char]](it))
  for row, line_data in charMap:
    for column, value in line_data.pairs:
      case value:
      of '#':
        artifacts.incl((row, column))
      of '^':
        start_guard_Position = (row, column)
      else:
        continue
  max = (len(charMap), len(charMap[0]))
  let part_1_visited = start_guard_Position.getVisited()
  let pt_1 = len(part_1_visited)
  var loops_found = 0
  for idx, p in part_1_visited.pairs:
    if start_guard_Position.isLoop(p):
      inc(loops_found)
  Solution(part_one: $pt_1, part_two: $loops_found)
