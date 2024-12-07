discard """
--- Day 7: Bridge Repair ---
The Historians take you to a familiar rope bridge over a river in the middle of a jungle. The Chief isn't on this side of the bridge, though; maybe he's on the other side?

When you go to cross the bridge, you notice a group of engineers trying to repair it. (Apparently, it breaks pretty frequently.) You won't be able to cross until it's fixed.

You ask how long it'll take; the engineers tell you that it only needs final calibrations, but some young elephants were playing nearby and stole all the operators from their calibration equations! They could finish the calibrations if only someone could determine which test values could possibly be produced by placing any combination of operators into their calibration equations (your puzzle input).

For example:

190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
Each line represents a single equation. The test value appears before the colon on each line; it is your job to determine whether the remaining numbers can be combined with operators to produce the test value.

Operators are always evaluated left-to-right, not according to precedence rules. Furthermore, numbers in the equations cannot be rearranged. Glancing into the jungle, you can see elephants holding two different types of operators: add (+) and multiply (*).

Only three of the above equations can be made true by inserting operators:

190: 10 19 has only one position that accepts an operator: between 10 and 19. Choosing + would give 29, but choosing * would give the test value (10 * 19 = 190).
3267: 81 40 27 has two positions for operators. Of the four possible configurations of the operators, two cause the right side to match the test value: 81 + 40 * 27 and 81 * 40 + 27 both equal 3267 (when evaluated left-to-right)!
292: 11 6 16 20 can be solved in exactly one way: 11 + 6 * 16 + 20.
The engineers just need the total calibration result, which is the sum of the test values from just the equations that could possibly be true. In the above example, the sum of the test values for the three equations listed above is 3749.

Determine which equations could possibly be true. What is their total calibration result?

Your puzzle answer was 850435817339.

--- Part Two ---
The engineers seem concerned; the total calibration result you gave them is nowhere close to being within safety tolerances. Just then, you spot your mistake: some well-hidden elephants are holding a third type of operator.

The concatenation operator (||) combines the digits from its left and right inputs into a single number. For example, 12 || 345 would become 12345. All operators are still evaluated left-to-right.

Now, apart from the three equations that could be made true using only addition and multiplication, the above example has three more equations that can be made true by inserting operators:

156: 15 6 can be made true through a single concatenation: 15 || 6 = 156.
7290: 6 8 6 15 can be made true using 6 * 8 || 6 * 15.
192: 17 8 14 can be made true using 17 || 8 + 14.
Adding up all six test values (the three that could be made before using only + and * plus the new three that can now be made by also using ||) produces the new total calibration result of 11387.

Using your new knowledge of elephant hiding spots, determine which equations could possibly be true. What is their total calibration result?

Your puzzle answer was 104824810233437.
"""
import std/[re, strscans, sequtils, strutils, strmisc, sugar, strformat]
import aoc_utils

import strutils
import std/math

#global bool gross
var is_pt2: bool

proc checkAllOps(values: seq[int], target: int, acc: int = 0): bool =
  if len(values) == 0:
    return target == acc
  elif target < acc:
    return false

  let first_val = values[0]
  let other_vals = values[1..^1]

  if other_vals.checkAllOps(target, acc + first_val):
    return true
  elif other_vals.checkAllOps(target, acc * first_val):
    return true

  #let digits = len($first_val)
  # thanks stackoverflow
  let digits =  int(floor(log10(float(first_val)))) + 1
  let cat_op = (acc * 10 ^ digits) + first_val

  if other_vals.checkAllOps(target, cat_op):
    if not is_pt2:
      is_pt2 = true
    return true
  else:
    return false

proc day_07*(): Solution =
  var pt1 = 0
  var pt2 = 0

  for line in getInput().splitlines:
    let parts = line.strip.split(" ")

    let target = parseInt(parts[0][0..^2])
    let values = parts[1..^1].mapIt(parseInt(it))
    is_pt2 = false
    if values.checkAllOps(target):
      if not is_pt2:
        pt1 += target
      pt2 += target

  Solution(part_one: $(pt1), part_two: $(pt2))