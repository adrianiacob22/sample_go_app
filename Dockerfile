FROM golang
RUN mkdir /go/src/app
ADD main.go /go/src/app/
WORKDIR /go/src/app
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o app .

#FROM scratch
WORKDIR /app
RUN cp /go/src/app/app .
ENTRYPOINT [ "./app" ]
