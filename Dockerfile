FROM debian:bookworm AS aoc2024

WORKDIR /repo

COPY . .

ENV PATH=/root/.nimble/bin:/root/.cargo/bin:$PATH

RUN apt-get update && \
  apt-get install -y curl xz-utils gcc openssl ca-certificates git && \
  curl https://nim-lang.org/choosenim/init.sh -sSf | bash -s -- -y && \
  curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | bash -s -- -y && \
  cargo install just && \
  apt -y autoremove && \
  apt -y clean && \
  rm -r /tmp/*

CMD ["bash"]
