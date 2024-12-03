import std/[strutils, os]

proc getInput*(): string =
  let filename = getEnv("AOC_INPUT", "inputs/hello_world")
  if fileExists filename:
    return strip(readFile filename)
  echo "Input file not found"
  quit(QuitFailure)

proc getDay*(): int =
  return (try: parseInt(getEnv("AOC_DAY")) except ValueError: -1)

type Solution* = object
  part_one*, part_two*: string

proc printSolution*(soln: Solution) =
  let prefix = "{\"part_one\":\""
  let infix = "\",\"part_two\":\""
  let suffix = "\"}"
  echo prefix, soln.part_one, infix, soln.part_two, suffix
  #echo $( %* soln)

proc notImplemented*() =
  echo "\"not implemented\""
  #echo $( %* "not implemented")
