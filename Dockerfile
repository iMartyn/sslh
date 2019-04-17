FROM alpine AS builder
RUN apk add --no-cache libconfig libconfig-dev make gcc build-base perl pcre-dev pcre
RUN mkdir /build
ADD . /build/
RUN cd /build; export USELIBWRAP=; make -e install

FROM alpine
RUN apk add --nocache libconfig pcre
COPY --from=builder /build/sslh-select /sslh
ENTRYPOINT ["/sslh"]
