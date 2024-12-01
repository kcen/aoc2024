build-cli:
  nim --out:dist/kcen-aoc --passL:-static --opt:speed -d:release c aoc.nim
  #nim --out:dist/kcen-aoc-prof --profiler:on c aoc.nim

container-build:
  docker run -itv ./dist/:/repo/dist/ aoc-dev just build-cli

build-dev-container:
  docker build -f Dockerfile -t aoc-dev .

build-bench:
  docker build -f Dockerfile.bench -t aoc-bench .
