new DAY NAME:
  scripts/new.sh {{DAY}} {{NAME}}

test:
  testament

build-cli:
  nim --out:dist/kcen-aoc --passL:-static --opt:speed  -d:release -r c aoc/aoc.nim

build-bench:
  docker build -f Dockerfile.bench -t aoc-bench .
