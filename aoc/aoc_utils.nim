import std/[strutils, os, json]

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
    echo $(%* soln)

proc notImplemented*() =
    echo $(%* "not implemented")
