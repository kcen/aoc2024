import std/[strutils, sequtils, algorithm]
import aoc_utils

proc day_01*(): Solution =
    var list_1: seq[int] = @[]
    var list_2: seq[int] = @[]
    for line in getInput().splitlines.mapIt(it.splitWhitespace(1)):
        let first = parseInt(line[0])
        let last = parseInt(line[1])
        list_1.add(first)
        list_2.add(last)
    list_1.sort
    list_2.sort
    var diff_count = 0
    for entry in zip(list_1, list_2):
        diff_count += abs(entry[0] - entry[1])

    var simm_score = 0
    for entry in list_1:
        simm_score += entry * count(list_2, entry)

    Solution(part_one: $diff_count, part_two: $simm_score)
