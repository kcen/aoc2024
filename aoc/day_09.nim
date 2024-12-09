import aoc_utils

type File = object
  start, len, id: int

proc toInt(c: char): int = 
  c.int - '0'.int

proc day_09*(): Solution =
  var files: seq[File] = @[]
  var gaps: seq[int] = @[]
  var i = 0
  var total_data = 0
  for idx, l in getInput():
    let length = toInt(l)
    if idx.mod(2) == 0:
      files.add(File(start:i, len: length, id: idx))
      total_data += length
    else:
      gaps.add(length)
    i += length
  
  var acc = 0

  var head_file = 0
  var tail_file = len(files) - 1
  var tail_count = 0

  # Part 1
  i = 0
  while head_file < tail_file:
    let next_file_len = files[head_file].len
    let next_gap_len = gaps[head_file]
    for _ in 0..<next_file_len:
      acc += head_file * i
      inc(i)
    for _ in 0..<next_gap_len:
      acc += tail_file * i
      inc(tail_count)
      if tail_count == files[tail_file].len:
        dec(tail_file)
        tail_count = 0
      inc(i)
      if i == total_data: break
    inc(head_file)
  for k in i..<total_data:
    acc += head_file * k
  
  let part_1 = acc

  Solution(part_one: $part_1, part_two: $(0))
