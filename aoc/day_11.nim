import std/[re, strscans, sequtils, sugar, strutils, math, tables, hashes]
import aoc_utils

type StoneCall = (int, int)

var stoneCache = initTable[StoneCall, int](4096)

func digits(n: int): int = 
  return int(floor(log10(float(n)))) + 1

proc splits(stone: int, n: int = 0): int =
  let cache_key: StoneCall = (stone, n)
  let len = digits(stone)
  if stoneCache.hasKey(cache_key):
    return stoneCache[cache_key]
  elif n == 0:
    result = 1
  elif stone == 0:
    result = splits(1, n - 1)
  elif len.mod(2) == 0:
    let divisor = int(10.pow(float(len/2)))
    result = splits(int(stone / divisor), n - 1) + splits(stone.mod(divisor), n - 1)
  else:
    result = splits(stone * 2024, n - 1)
  stoneCache[cache_key] = result
  return result

proc day_11*(): Solution =
  let stones = getInput().split.mapIt(it.parseInt.int)
  let pt_1 = stones.mapIt(it.splits(25)).sum()
  let pt_2 = stones.mapIt(it.splits(75)).sum()
  Solution(part_one: $(pt_1), part_two: $(pt_2))