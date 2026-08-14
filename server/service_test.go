package server_test

import (
	"context"
	"encoding/json"
	"testing"

	server "github.com/opto-sync-test/grpc-go-flutter-e2e/server"
	syncv1 "github.com/opto-sync-test/grpc-go-flutter-e2e/server/gen"
)

func TestMergeUsesPinnedCore(t *testing.T) {
	response, err := (server.SyncService{}).Merge(context.Background(), &syncv1.MergeRequest{
		BaseJson:     `{"id":"doc-1","profile":{"server":"kept"},"items":[{"id":"a","server":true}]}`,
		IncomingJson: `{"profile":{"client":"kept"},"items":[{"id":"a","client":true}]}`,
	})
	if err != nil {
		t.Fatalf("Merge returned an error: %v", err)
	}
	if response.GetCoreVersion() == "" {
		t.Fatal("Merge did not report the native core version")
	}

	var merged map[string]any
	if err := json.Unmarshal([]byte(response.GetMergedJson()), &merged); err != nil {
		t.Fatalf("merged_json is invalid: %v", err)
	}
	profile := merged["profile"].(map[string]any)
	if profile["server"] != "kept" || profile["client"] != "kept" {
		t.Fatalf("nested profile was not deeply merged: %#v", profile)
	}
	item := merged["items"].([]any)[0].(map[string]any)
	if item["server"] != true || item["client"] != true {
		t.Fatalf("array item was not merged by id: %#v", item)
	}
}
