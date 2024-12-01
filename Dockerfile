FROM nimlang/choosenim:latest AS aoc2024

WORKDIR /repo

COPY . .

CMD ["bash"]
