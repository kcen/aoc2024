discard """
--- Day 4: Ceres Search ---
"Looks like the Chief's not here. Next!" One of The Historians pulls out a device and pushes the only button on it. After a brief flash, you recognize the interior of the Ceres monitoring station!

As the search for the Chief continues, a small Elf who lives on the station tugs on your shirt; she'd like to know if you could help her with her word search (your puzzle input). She only has to find one word: XMAS.

This word search allows words to be horizontal, vertical, diagonal, written backwards, or even overlapping other words. It's a little unusual, though, as you don't merely need to find one instance of XMAS - you need to find all of them. Here are a few ways XMAS might appear, where irrelevant characters have been replaced with .:


..X...
.SAMX.
.A..A.
XMAS.S
.X....
The actual word search will be full of letters instead. For example:

MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
In this word search, XMAS occurs a total of 18 times; here's the same word search again, but where letters not involved in any XMAS have been replaced with .:

....XXMAS.
.SAMXMS...
...S..A...
..A.A.MS.X
XMASAMX.MM
X.....XA.A
S.S.S.S.SS
.A.A.A.A.A
..M.M.M.MM
.X.X.XMASX
Take a look at the little Elf's word search. How many times does XMAS appear?

Your puzzle answer was 2521.

--- Part Two ---
The Elf looks quizzically at you. Did you misunderstand the assignment?

Looking for the instructions, you flip over the word search to find that this isn't actually an XMAS puzzle; it's an X-MAS puzzle in which you're supposed to find two MAS in the shape of an X. One way to achieve that is like this:

M.S
.A.
M.S
Irrelevant characters have again been replaced with . in the above diagram. Within the X, each MAS can be written forwards or backwards.

Here's the same example from before, but this time all of the X-MASes have been kept instead:

.M.S......
..A..MSMS.
.M.S.MAA..
..A.ASMSM.
.M.S.M....
..........
S.S.S.S.S.
.A.A.A.A..
M.M.M.M.M.
..........
In this example, an X-MAS appears 9 times.

Flip the word search from the instructions back over to the word search side and try again. How many times does an X-MAS appear?

Your puzzle answer was 1912.
"""
import std/[strutils, sequtils, algorithm]
import aoc_utils

type SeqGrid[char] = seq[seq[char]]
const xmas = "XMAS".items.toSeq()
const samx = "SAM".items.toSeq()
const maxDepth = 3
const directions = @[(-1, -1), (0, -1), (1, -1), (-1, 0), (1, 0), (-1, 1), (0, 1), (1, 1)]
const diags = @[(-1, -1), (-1, 1), (1, -1), (1, 1)]
const sortedSamx = @['M', 'M', 'S', 'S']


proc searchXmas(grid: SeqGrid, row: int, col: int, direction: (int, int), depth: int): bool =
  let (down, right) = direction
  let next_row = row + down
  let next_col = col + right
  if next_row < 0 or next_col < 0 or next_row == len(grid) or next_col == len(grid[0]):
    return false
  elif grid[next_row][next_col] == xmas[depth]:
    if depth == maxDepth:
      return true
    else:
      return grid.searchXmas(next_row, next_col, direction, depth + 1)
  return false

proc searchSamx(grid: SeqGrid, row: int, col: int): bool =
  if row == 0 or col == 0 or row == len(grid)-1 or col == len(grid[0])-1:
    return false
  var vals: seq[char]
  for val in diags:
    let (down, right) = val
    vals.add(grid[row + down][col + right])
  if vals.count('M') == 2 and vals.count('S') == 2:
    if vals[0] != vals[3]:
      return true
  return false

proc day_04*(): Solution =
  let grid = getInput().splitlines.mapIt(cast[seq[char]](it))
  let height = len(grid)
  let width = len(grid[0])

  var part_1_total = 0
  var part_2_total = 0
  for row in 0..<height:
    for col in 0..<width:
      if grid[row][col] == xmas[0]:
        for d in directions:
          if grid.searchXmas(row, col, d, 1):
            part_1_total += 1
      elif grid[row][col] == samx[1]:
        if grid.searchSamx(row, col):
          part_2_total += 1

  Solution(part_one: $part_1_total, part_two: $part_2_total)
