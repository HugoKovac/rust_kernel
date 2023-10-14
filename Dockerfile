FROM ubuntu:latest

WORKDIR /root
RUN apt-get update && apt-get install -y curl build-essential
SHELL ["/bin/bash", "-c"]
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- --default-toolchain nightly -y 
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustup target add i686-unknown-linux-gnu
RUN rustup component add rust-src --toolchain nightly-x86_64-unknown-linux-gnu
RUN echo -e "[unstable]\nbuild-std = [\"core\", \"compiler_builtins\"]" >> /root/.cargo/config
