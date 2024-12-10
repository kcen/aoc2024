discard """--- Day 9: Disk Fragmenter ---
Another push of the button leaves you in the familiar hallways of some friendly amphipods! Good thing you each somehow got your own personal mini submarine. The Historians jet away in search of the Chief, mostly by driving directly into walls.

While The Historians quickly figure out how to pilot these things, you notice an amphipod in the corner struggling with his computer. He's trying to make more contiguous free space by compacting all of the files, but his program isn't working; you offer to help.

He shows you the disk map (your puzzle input) he's already generated. For example:

2333133121414131402
The disk map uses a dense format to represent the layout of files and free space on the disk. The digits alternate between indicating the length of a file and the length of free space.

So, a disk map like 12345 would represent a one-block file, two blocks of free space, a three-block file, four blocks of free space, and then a five-block file. A disk map like 90909 would represent three nine-block files in a row (with no free space between them).

Each file on disk also has an ID number based on the order of the files as they appear before they are rearranged, starting with ID 0. So, the disk map 12345 has three files: a one-block file with ID 0, a three-block file with ID 1, and a five-block file with ID 2. Using one character for each block where digits are the file ID and . is free space, the disk map 12345 represents these individual blocks:

0..111....22222
The first example above, 2333133121414131402, represents these individual blocks:

00...111...2...333.44.5555.6666.777.888899
The amphipod would like to move file blocks one at a time from the end of the disk to the leftmost free space block (until there are no gaps remaining between file blocks). For the disk map 12345, the process looks like this:

0..111....22222
02.111....2222.
022111....222..
0221112...22...
02211122..2....
022111222......
The first example requires a few more steps:

00...111...2...333.44.5555.6666.777.888899
009..111...2...333.44.5555.6666.777.88889.
0099.111...2...333.44.5555.6666.777.8888..
00998111...2...333.44.5555.6666.777.888...
009981118..2...333.44.5555.6666.777.88....
0099811188.2...333.44.5555.6666.777.8.....
009981118882...333.44.5555.6666.777.......
0099811188827..333.44.5555.6666.77........
00998111888277.333.44.5555.6666.7.........
009981118882777333.44.5555.6666...........
009981118882777333644.5555.666............
00998111888277733364465555.66.............
0099811188827773336446555566..............
The final step of this file-compacting process is to update the filesystem checksum. To calculate the checksum, add up the result of multiplying each of these blocks' position with the file ID number it contains. The leftmost block is in position 0. If a block contains free space, skip it instead.

Continuing the first example, the first few blocks' position multiplied by its file ID number are 0 * 0 = 0, 1 * 0 = 0, 2 * 9 = 18, 3 * 9 = 27, 4 * 8 = 32, and so on. In this example, the checksum is the sum of these, 1928.

Compact the amphipod's hard drive using the process he requested. What is the resulting filesystem checksum? (Be careful copy/pasting the input for this puzzle; it is a single, very long line.)

Your puzzle answer was 6378826667552.

--- Part Two ---
Upon completion, two things immediately become clear. First, the disk definitely has a lot more contiguous free space, just like the amphipod hoped. Second, the computer is running much more slowly! Maybe introducing all of that file system fragmentation was a bad idea?

The eager amphipod already has a new plan: rather than move individual blocks, he'd like to try compacting the files on his disk by moving whole files instead.

This time, attempt to move whole files to the leftmost span of free space blocks that could fit the file. Attempt to move each file exactly once in order of decreasing file ID number starting with the file with the highest file ID number. If there is no span of free space to the left of a file that is large enough to fit the file, the file does not move.

The first example from above now proceeds differently:

00...111...2...333.44.5555.6666.777.888899
0099.111...2...333.44.5555.6666.777.8888..
0099.1117772...333.44.5555.6666.....8888..
0099.111777244.333....5555.6666.....8888..
00992111777.44.333....5555.6666.....8888..
The process of updating the filesystem checksum is the same; now, this example's checksum would be 2858.

Start over, now compacting the amphipod's hard drive using this new method instead. What is the resulting filesystem checksum?

Your puzzle answer was 6413328569890.
"""
import aoc_utils

type File = object
  # id == -1 for vacated slot
  len, id: int

proc toInt(c: char): int =
  c.int - '0'.int

proc lastSmallerThan(file_list: seq[File], gap_size: int): int =
  let num_files = len(file_list)
  for i in 1..num_files:
    let next_file = file_list[num_files - i]
    if next_file.id != -1 and next_file.len <= gap_size:
      return next_file.id
  return -1

proc day_09*(): Solution =
  var files: seq[File] = @[]
  var gaps: seq[int] = @[]
  var i = 0
  var total_data = 0
  var acc = 0
  for idx, l in getInput():
    let length = toInt(l)
    if idx.mod(2) == 0:
      files.add(File(len: length, id: int(idx/2)))
      total_data += length
    else:
      gaps.add(length)
    i += length

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


#Algorithm
# Repeat
#   Take a file
#   Take a gap
#   Take last file that fits the gap
#   Repeat
#     Recalculate gap
#     Take last file that fits gap
  head_file = 0
  tail_file = len(files) - 1
  acc = 0
  i = 0
  #var out_string = ""
  while head_file < tail_file: #fixme
    #Take a file
    let head = files[head_file]
    if head.id == -1:
      #for _ in 1..head.len:
      #  out_string.add(".")
      #  inc(i)
      i += head.len
    else:
      for _ in 1..head.len:
        acc += i * head.id
        #out_string.add($(head.id))
        inc(i)
      files[head_file].id = -1
      total_data -= head.len

    # Take a gap
    var next_gap = gaps[head_file]

    while true:
      if next_gap < 1: break
      var next_available = files.lastSmallerThan(next_gap)
      if next_available != -1:
        let file_to_move = files[next_available]
        for _ in 1..file_to_move.len:
          acc += i * file_to_move.id
          #out_string.add($(file_to_move.id))
          inc(i)
          dec(next_gap)
        total_data -= head.len
        files[next_available].id = -1
      else:
        break
    #for _ in 1..next_gap:
    #  out_string.add(".")
    #  inc(i)
    i += next_gap
    inc(head_file)

  #echo out_string

  Solution(part_one: $part_1, part_two: $(acc))
