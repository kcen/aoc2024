FROM nimlang/choosenim:latest

WORKDIR /repo

COPY . .

CMD ["bash"]