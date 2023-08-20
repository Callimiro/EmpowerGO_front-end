FROM golang:1.19-alpine as builder 
# Create app directory
WORKDIR /app
# Copy go mod and sum files
COPY go.mod ./
# Download all dependencies
RUN go mod download
# Copy source code into the container
COPY . .

# Build the Go app
RUN go build -o fronte-end ./cmd/web

FROM alpine:latest  

WORKDIR /app 
 
COPY --from=builder /app/fronte-end ./

# Command to run the executable
CMD ["./fronte-end"]