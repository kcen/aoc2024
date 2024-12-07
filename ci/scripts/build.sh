#!/bin/bash
nimble --out:dist/kcen-aoc --threads:on --opt:speed -d:release -d:danger --gc:orc c aoc.nim
