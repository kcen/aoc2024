import std/[strutils, strscans, sequtils, algorithm, tables, sugar, math, sets]
import aoc_utils

var 
  rules: HashSet[(int, int)]
  page_lists: seq[seq[int]]

proc outOfOrder(x, y: int): bool =
  rules.contains((y,x))

proc isSorted(page_list: seq[int]): bool =
  var check_page = page_list.dup()
  let check_length = len(page_list) - 1
  for i in (0..<check_length):
    let next_i = i + 1
    for k in (next_i..check_length):
      if outOfOrder(check_page[i], check_page[k]):
        return false
  return true

proc day_05*(): Solution =
  var rulevals: seq[(int, int)] = @[]
  for line in getInput().splitlines:
    let (is_rule, left_rule, right_rule) = line.scanTuple("$i|$i")
    if is_rule:
      rulevals.add((left_rule, right_rule))
    else:
      try:
        let vals = line.split(',').mapIt(parseInt(it))
        page_lists.add(vals)
      except:
        continue
  
  rules = rulevals.toHashSet()
  var tot = 0
  for pages in page_lists:
    if isSorted(pages):
      let mid_val = pages[pages.len().floorDiv(2)]
      tot += mid_val

  result = Solution(part_one: $tot, part_two: "abc")
