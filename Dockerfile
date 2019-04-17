FROM debian AS builder
RUN apt update && apt install libconfig9 libconfig-dev libwrap0 libwrap0-dev build-essential perl libpcre3-dev libpcre3 -y
RUN mkdir /build
ADD . /build/
RUN cd /build; export USELIBWRAP=; make -e install

FROM debian
RUN apt update && apt install libconfig9 libpcre3 libwrap0 -y
COPY --from=builder /build/sslh-select /sslh
ENTRYPOINT ["/sslh"]
