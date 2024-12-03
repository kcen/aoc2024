build-cli:
  nimble --out:dist/kcen-aoc --passL:-static --opt:speed -d:release c aoc.nim

container-build:
  docker run -itv ./dist/:/repo/dist/ aoc-dev just build-cli

build-dev-container:
  docker build -f Dockerfile -t aoc-dev .

build-bench:
  docker build -f Dockerfile.bench -t aoc-bench .

run_day DAY INPUT:
  /usr/bin/env AOC_DAY={{DAY}} AOC_INPUT={{INPUT}} nimble c --out:dist/kcen-aoc-debug -d:nimDebugDlOpen --silent -r --hints:off aoc.nim

fast_bench DAY INPUT: build-cli
  /usr/bin/env AOC_DAY={{DAY}} AOC_INPUT={{INPUT}} hyperfine dist/kcen-aoc
