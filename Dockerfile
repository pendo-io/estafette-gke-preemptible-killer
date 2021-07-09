FROM circleci/golang:1.14 as build

COPY . /home/circleci/gke-preemp-killer

WORKDIR /home/circleci/gke-preemp-killer

RUN go build -v -o /tmp/gke-preemp-killer *.go &&\
    chmod +x /tmp/gke-preemp-killer

FROM gcr.io/pendo-dev/base-runtime:latest

COPY --from=build /tmp/gke-preemp-killer /opt/gke-preemp-killer

ENTRYPOINT ["/opt/gke-preemp-killer"]