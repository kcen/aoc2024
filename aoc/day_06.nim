
import std/[strutils, strscans, sequtils, sugar, math, algorithm]
import aoc_utils, itertools

type Pos = (int, int)

#Position is bigger Row == Down, bigger Column == Right
# These correspond to Up, Right, Left, Down TODO: ENUM
var directions = @[(-1, 0), (0, 1), (1, 0), (0, -1)]
var max: Pos

func `+`(x, y: Pos): Pos =
  (x[0] + y[0], x[1] + y[1])

proc inbounds(max: Pos, current: Pos): bool =
  if current[0] < 0 or current[0] > max[0] or current[1] < 0 or current[1] > max[1]:
    return false
  return true

proc day_06*(): Solution =
  var artifacts: seq[Pos] = @[]
  var start_guard_Position: Pos
  var visited: seq[Pos] = @[]

  var charMap = getInput().splitlines.mapIt(cast[seq[char]](it))
  for row, line_data in charMap:
    for column, value in line_data.pairs:
      case value:
      of '#':
        artifacts.add((row, column))
      of '^':
        start_guard_Position = (row, column)
      else:
        continue
  max = (len(charMap) - 1, len(charMap[0]) - 1)
  var heading = 0
  var guard_Position = start_guard_Position
  while max.inbounds(guard_Position):
    visited.add(guard_Position)
    var next_Position = guard_Position + directions[heading]
    if artifacts.contains(next_Position):
      heading = (heading + 1) mod 4
      next_Position = guard_Position + directions[heading]
    guard_Position = next_Position

  visited.sort()
  let part_1_visited = visited.deduplicate(true)
  let pt_1 = len(part_1_visited)
  var visited_with_direction: seq[(Pos, int)]
  var loops_found = 0
  var break_me = 0
  # for p in part_1_visited:
  #   break_me = 0
  #   heading = 0
  #   visited_with_direction = @[]
  #   guard_Position = start_guard_Position
  #   while max.inbounds(guard_Position):
  #     if visited_with_direction.contains((guard_Position, heading)):
  #       inc(loops_found)
  #       break
  #     visited_with_direction.add((guard_Position, heading))
  #     var next_Position = guard_Position + directions[heading]
  #     if next_Position == p or artifacts.contains(next_Position):
  #       heading = (heading + 1) mod 4
  #       next_Position = guard_Position + directions[heading]
  #     guard_Position = next_Position
  #     inc(break_me)
  #     if break_me > 10000:
  #       break
  Solution(part_one: $pt_1, part_two: $loops_found)