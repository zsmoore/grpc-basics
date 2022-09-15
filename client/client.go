package main

import (
	"context"
	"flag"
	"log"
	"time"

	pb "example/grpc/hello"

	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

const (
	defaultInput = "example"
)

var (
	addr  = flag.String("addr", "localhost:50051", "the address to connect to")
	input = flag.String("input", defaultInput, "input to server")
)

func main() {
	flag.Parse()
	// Set up a connection to the server.
	conn, err := grpc.Dial(*addr, grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		log.Fatalf("did not connect: %v", err)
	}
	defer conn.Close()
	c := pb.NewHelloClient(conn)

	// Contact the server and print out its response.
	ctx, cancel := context.WithTimeout(context.Background(), time.Second)
	defer cancel()
	r, err := c.Echo(ctx, &pb.Input{Input: *input})
	if err != nil {
		log.Fatalf("could not greet: %v", err)
	}
	log.Printf("Received: %s", r.GetOutput())
}
