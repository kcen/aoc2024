build-cli:
  nim --out:dist/kcen-aoc --passL:-static --opt:speed  -d:release -r c aoc.nim

build-bench:
  docker build -f Dockerfile.bench -t aoc-bench .
