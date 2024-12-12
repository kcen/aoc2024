import aoc/[aoc_utils, day_00, day_01, day_02, day_03, day_04, day_05, day_06, day_07, day_08, day_09, day_10, day_11, day_12]
when compileOption("profiler"):
  import nimprof

case getDay():
  of 0:
    printSolution day_00()
  of 1:
    printSolution day_01()
  of 2:
    printSolution day_02()
  of 3:
    printSolution day_03()
  of 4:
    printSolution day_04()
  of 5:
    printSolution day_05()
  of 6:
    printSolution day_06()
  of 7:
    printSolution day_07()
  of 8:
    printSolution day_08()
  of 9:
    printSolution day_09()
  of 10:
    printSolution day_10()
  of 11:
    printSolution day_11()
  of 12:
    printSolution day_12()
  else:
    notImplemented()
