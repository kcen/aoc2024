version      = "0.0.0"
author       = "Casey"
description  = "AOC 2024"
license      = "NONE"
srcDir       = "."
bin          = @["kcen-aoc"]

skipDirs = @["tests"]
installFiles = @["aoc.nim"]
installDirs  = @["aoc"]
installExt = @["nim"]

# Dependencies
requires "nim >= 2.2.0"
