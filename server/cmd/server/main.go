package main

import (
	"fmt"
	"log"
	"net"
	"os"

	server "github.com/opto-sync-test/grpc-go-flutter-e2e/server"
	syncv1 "github.com/opto-sync-test/grpc-go-flutter-e2e/server/gen"
	"google.golang.org/grpc"
)

func main() {
	port := os.Getenv("OPTO_SYNC_GRPC_PORT")
	if port == "" {
		port = "50051"
	}

	listener, err := net.Listen("tcp", "127.0.0.1:"+port)
	if err != nil {
		log.Fatal(err)
	}

	grpcServer := grpc.NewServer()
	syncv1.RegisterSyncServiceServer(grpcServer, server.SyncService{})
	fmt.Printf("opto-sync gRPC server listening on %s\n", listener.Addr())
	if err := grpcServer.Serve(listener); err != nil {
		log.Fatal(err)
	}
}
