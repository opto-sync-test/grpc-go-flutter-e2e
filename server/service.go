package server

import (
	"context"
	"encoding/json"
	"io"

	syncv1 "github.com/opto-sync-test/grpc-go-flutter-e2e/server/gen"
	syncer "github.com/opto-sync/syncer-go"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

// SyncService crosses the gRPC boundary before delegating reconciliation to
// the exact syncer.c revision vendored by this repository.
type SyncService struct {
	syncv1.UnimplementedSyncServiceServer
}

func (SyncService) Health(context.Context, *syncv1.HealthRequest) (*syncv1.HealthResponse, error) {
	return &syncv1.HealthResponse{CoreVersion: syncer.Version()}, nil
}

func (SyncService) Merge(_ context.Context, request *syncv1.MergeRequest) (*syncv1.MergeResponse, error) {
	if !json.Valid([]byte(request.GetBaseJson())) || !json.Valid([]byte(request.GetIncomingJson())) {
		return nil, status.Error(codes.InvalidArgument, "base_json and incoming_json must be valid JSON")
	}

	merged, err := syncer.MergeJSONWithOptions(
		request.GetBaseJson(),
		request.GetIncomingJson(),
		syncer.Options{
			ArrayStrategy:      syncer.ArrayMergeByKey,
			ResolveByTimestamp: true,
			LwwKeys:            "updatedAt,syncedAt",
			ArrayMatchKeys:     "id",
		},
	)
	if err != nil {
		return nil, status.Errorf(codes.InvalidArgument, "merge failed: %v", err)
	}

	return &syncv1.MergeResponse{
		MergedJson:  merged,
		CoreVersion: syncer.Version(),
	}, nil
}

// Sync keeps one bidirectional stream alive while independent logical lanes
// are multiplexed by lane and sequence. Each response preserves that identity,
// so reconnecting clients can replay unacknowledged frames without confusing
// one document lane for another.
func (service SyncService) Sync(stream syncv1.SyncService_SyncServer) error {
	for {
		request, err := stream.Recv()
		if err == io.EOF {
			return nil
		}
		if err != nil {
			return err
		}
		if request.GetLane() == "" || request.GetSequence() == 0 {
			return status.Error(codes.InvalidArgument, "lane and positive sequence are required")
		}
		merged, err := service.Merge(stream.Context(), &syncv1.MergeRequest{
			BaseJson:     request.GetBaseJson(),
			IncomingJson: request.GetIncomingJson(),
		})
		if err != nil {
			return err
		}
		if err := stream.Send(&syncv1.SyncResponse{
			Lane:        request.GetLane(),
			Sequence:    request.GetSequence(),
			MergedJson:  merged.GetMergedJson(),
			CoreVersion: merged.GetCoreVersion(),
		}); err != nil {
			return err
		}
	}
}
