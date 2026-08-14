// This is a generated file - do not edit.
//
// Generated from sync.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'sync.pb.dart' as $0;

export 'sync.pb.dart';

@$pb.GrpcServiceName('optosync.v1.SyncService')
class SyncServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  SyncServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.HealthResponse> health(
    $0.HealthRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$health, request, options: options);
  }

  $grpc.ResponseFuture<$0.MergeResponse> merge(
    $0.MergeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$merge, request, options: options);
  }

  // method descriptors

  static final _$health =
      $grpc.ClientMethod<$0.HealthRequest, $0.HealthResponse>(
          '/optosync.v1.SyncService/Health',
          ($0.HealthRequest value) => value.writeToBuffer(),
          $0.HealthResponse.fromBuffer);
  static final _$merge = $grpc.ClientMethod<$0.MergeRequest, $0.MergeResponse>(
      '/optosync.v1.SyncService/Merge',
      ($0.MergeRequest value) => value.writeToBuffer(),
      $0.MergeResponse.fromBuffer);
}

@$pb.GrpcServiceName('optosync.v1.SyncService')
abstract class SyncServiceBase extends $grpc.Service {
  $core.String get $name => 'optosync.v1.SyncService';

  SyncServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.HealthRequest, $0.HealthResponse>(
        'Health',
        health_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HealthRequest.fromBuffer(value),
        ($0.HealthResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MergeRequest, $0.MergeResponse>(
        'Merge',
        merge_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.MergeRequest.fromBuffer(value),
        ($0.MergeResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.HealthResponse> health_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.HealthRequest> $request) async {
    return health($call, await $request);
  }

  $async.Future<$0.HealthResponse> health(
      $grpc.ServiceCall call, $0.HealthRequest request);

  $async.Future<$0.MergeResponse> merge_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.MergeRequest> $request) async {
    return merge($call, await $request);
  }

  $async.Future<$0.MergeResponse> merge(
      $grpc.ServiceCall call, $0.MergeRequest request);
}
