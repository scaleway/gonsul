ARG GONSUL=/go/src/github.com/scaleway/gonsul

FROM golang:1.24.2-alpine AS build

ARG GONSUL

RUN apk --no-cache add build-base git make

RUN mkdir -p $GONSUL

WORKDIR $GONSUL

COPY . .

RUN make

FROM alpine

ARG GONSUL

COPY --from=build $GONSUL/bin/gonsul /usr/bin/gonsul

RUN adduser -D gonsul

USER gonsul

ENTRYPOINT [ "/usr/bin/gonsul" ]
