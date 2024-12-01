import std/[strutils, strformat, sequtils, algorithm, os, json]
import std/[sets, intsets, tables, options, monotimes, times, paths]

type Solution* = object
    part_one, part_two: string

proc getInput*(): string =
    let filename = getEnv("AOC_INPUT", "inputs/hello_world")
    if fileExists filename:
        return readFile filename
    echo "Input file not found"
    quit(QuitFailure)

proc getDay(): int =
    return parseInt(getEnv("AOC_DAY", "00"))


echo $(%* Solution(part_one: cast[string](getDay()), part_two:getEnv("AOC_INPUT", "inputs/hello_world")))