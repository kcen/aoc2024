build-cli:
  ./ci/scripts/build.sh

build_containers:
  docker build -f Dockerfile -t aoc-dev .
  docker build -f Dockerfile.bench -t aoc-bench .

container-compile:
  docker run -itv .:/repo/ aoc-dev just build-cli

fast_bench DAY INPUT: build-cli
  cp {{INPUT}} /tmp/aoc-input
  cp dist/kcen-aoc /tmp/kcen-aoc
  /usr/bin/env AOC_DAY={{DAY}} AOC_INPUT=/tmp/aoc-input hyperfine -w 2 -u microsecond -N /tmp/kcen-aoc

fast_run DAY INPUT: build-cli
  cp {{INPUT}} /tmp/aoc-input
  cp dist/kcen-aoc /tmp/kcen-aoc
  /usr/bin/env AOC_DAY={{DAY}} AOC_INPUT=/tmp/aoc-input /tmp/kcen-aoc

profile_day DAY INPUT:
  /usr/bin/env AOC_DAY={{DAY}} AOC_INPUT={{INPUT}} nimble c --threads:on --out:dist/kcen-aoc-debug --profiler:on --stackTrace:on -d:nimDebugDlOpen --silent -r --hints:off aoc.nim

run_day DAY INPUT:
  /usr/bin/env AOC_DAY={{DAY}} AOC_INPUT={{INPUT}} nimble c --threads:on --out:dist/kcen-aoc-debug -d:nimDebugDlOpen --silent -r --hints:off aoc.nim
