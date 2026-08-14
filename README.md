# Go + Flutter gRPC Opto-Sync E2E

This repository proves that a Flutter client can cross a generated protobuf/gRPC boundary and reconcile data with the exact Opto-Sync C core compiled into a Go service.

## What the test covers

- the Flutter side imports the official Dart Opto-Sync client and issues a cross-language hybrid logical clock timestamp;
- protobuf generates both the Dart client and Go server contracts from `proto/sync.proto`;
- a real TCP gRPC call reaches the Go service;
- one bidirectional gRPC stream carries independently sequenced document lanes,
  and the Flutter worker replays the immutable batch after an unavailable
  server reconnects;
- the official Go binding compiles the pinned `syncer.c` sources through cgo;
- nested objects and array elements matched by `id` retain independent server and client fields;
- health and merge responses expose the native engine version.

The application layer also registers the same durable drain with
`workmanager` on Android, iOS Background Fetch, macOS, and Linux. The web build
ships a compiled Flutter-free dispatcher plus Workmanager's Service Worker and
Web Worker; browsers use concurrent gRPC-Web frames because gRPC-Web does not
support client streaming. Windows uses the same long-lived worker contract in
the desktop process because Workmanager does not currently provide a Windows
OS scheduler. CI materializes clean Flutter platform shells and compiles web,
Android, iOS simulator, Linux, macOS, and Windows targets, so platform plugin
and native build drift is caught rather than inferred from host-only tests.

The dependency boundary is reproducible: `vendor/opto-sync-clients` is a Git submodule, its nested `syncer.c` submodule is initialized recursively, and both revisions are recorded in `opto-sync-pin.json`.

## Run locally

Prerequisites: Go 1.24+, Flutter 3.44+/Dart 3.12+, a C compiler, and protobuf only when regenerating checked-in clients.

```sh
git submodule update --init --recursive
(cd server && go test ./... && go build -o ../.build/grpc-server ./cmd/server)
(cd app && flutter pub get && flutter test)
```

The generated platform shells are deliberately not vendored except for the
iOS background-fetch settings and web worker assets. Run `flutter create` for
the platform you want, as CI does; existing background configuration is
preserved.

To regenerate the checked-in protobuf clients, install `protoc-gen-go`, `protoc-gen-go-grpc`, and Dart's `protoc_plugin`, then run the generation command documented in the CI workflow.
