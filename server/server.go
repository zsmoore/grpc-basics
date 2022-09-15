package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"net"

	pb "example/grpc/hello"

	"google.golang.org/grpc"
)

var (
	port = flag.Int("port", 50051, "The server port")
)

type server struct {
	pb.UnimplementedHelloServer
}

func (s *server) Echo(ctx context.Context, in *pb.Input) (*pb.Output, error) {
	log.Printf("Received: %v", in.GetInput())
	return &pb.Output{Output: in.GetInput() + in.GetInput()}, nil
}

func main() {
	flag.Parse()
	lis, err := net.Listen("tcp", fmt.Sprintf(":%d", *port))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()
	pb.RegisterHelloServer(s, &server{})
	log.Printf("server listening at %v", lis.Addr())
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
