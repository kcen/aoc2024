import aoc/[aoc_utils,day_00,day_01]

case getDay():
    of 0:
        printSolution(day_00(""))
    of 1:
        printSolution(day_01(getInput()))
    else:
        notImplemented()
