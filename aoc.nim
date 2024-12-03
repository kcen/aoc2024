import aoc/[aoc_utils, day_00, day_01, day_02, day_03]

case getDay():
  of 0:
    printSolution day_00()
  of 1:
    printSolution day_01()
  of 2:
    printSolution day_02()
  of 3:
    printSolution day_03()
  else:
    notImplemented()
