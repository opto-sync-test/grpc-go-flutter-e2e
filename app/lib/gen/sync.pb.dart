// This is a generated file - do not edit.
//
// Generated from sync.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class HealthRequest extends $pb.GeneratedMessage {
  factory HealthRequest() => create();

  HealthRequest._();

  factory HealthRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HealthRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HealthRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'optosync.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HealthRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HealthRequest copyWith(void Function(HealthRequest) updates) =>
      super.copyWith((message) => updates(message as HealthRequest))
          as HealthRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HealthRequest create() => HealthRequest._();
  @$core.override
  HealthRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HealthRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HealthRequest>(create);
  static HealthRequest? _defaultInstance;
}

class HealthResponse extends $pb.GeneratedMessage {
  factory HealthResponse({
    $core.String? coreVersion,
  }) {
    final result = create();
    if (coreVersion != null) result.coreVersion = coreVersion;
    return result;
  }

  HealthResponse._();

  factory HealthResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HealthResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HealthResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'optosync.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'coreVersion')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HealthResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HealthResponse copyWith(void Function(HealthResponse) updates) =>
      super.copyWith((message) => updates(message as HealthResponse))
          as HealthResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HealthResponse create() => HealthResponse._();
  @$core.override
  HealthResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HealthResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HealthResponse>(create);
  static HealthResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get coreVersion => $_getSZ(0);
  @$pb.TagNumber(1)
  set coreVersion($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCoreVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearCoreVersion() => $_clearField(1);
}

class MergeRequest extends $pb.GeneratedMessage {
  factory MergeRequest({
    $core.String? baseJson,
    $core.String? incomingJson,
  }) {
    final result = create();
    if (baseJson != null) result.baseJson = baseJson;
    if (incomingJson != null) result.incomingJson = incomingJson;
    return result;
  }

  MergeRequest._();

  factory MergeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MergeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MergeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'optosync.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'baseJson')
    ..aOS(2, _omitFieldNames ? '' : 'incomingJson')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MergeRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MergeRequest copyWith(void Function(MergeRequest) updates) =>
      super.copyWith((message) => updates(message as MergeRequest))
          as MergeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MergeRequest create() => MergeRequest._();
  @$core.override
  MergeRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MergeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MergeRequest>(create);
  static MergeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get baseJson => $_getSZ(0);
  @$pb.TagNumber(1)
  set baseJson($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBaseJson() => $_has(0);
  @$pb.TagNumber(1)
  void clearBaseJson() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get incomingJson => $_getSZ(1);
  @$pb.TagNumber(2)
  set incomingJson($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIncomingJson() => $_has(1);
  @$pb.TagNumber(2)
  void clearIncomingJson() => $_clearField(2);
}

class MergeResponse extends $pb.GeneratedMessage {
  factory MergeResponse({
    $core.String? mergedJson,
    $core.String? coreVersion,
  }) {
    final result = create();
    if (mergedJson != null) result.mergedJson = mergedJson;
    if (coreVersion != null) result.coreVersion = coreVersion;
    return result;
  }

  MergeResponse._();

  factory MergeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MergeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MergeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'optosync.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'mergedJson')
    ..aOS(2, _omitFieldNames ? '' : 'coreVersion')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MergeResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MergeResponse copyWith(void Function(MergeResponse) updates) =>
      super.copyWith((message) => updates(message as MergeResponse))
          as MergeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MergeResponse create() => MergeResponse._();
  @$core.override
  MergeResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MergeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MergeResponse>(create);
  static MergeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mergedJson => $_getSZ(0);
  @$pb.TagNumber(1)
  set mergedJson($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMergedJson() => $_has(0);
  @$pb.TagNumber(1)
  void clearMergedJson() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get coreVersion => $_getSZ(1);
  @$pb.TagNumber(2)
  set coreVersion($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCoreVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearCoreVersion() => $_clearField(2);
}

class SyncRequest extends $pb.GeneratedMessage {
  factory SyncRequest({
    $core.String? lane,
    $fixnum.Int64? sequence,
    $core.String? baseJson,
    $core.String? incomingJson,
  }) {
    final result = create();
    if (lane != null) result.lane = lane;
    if (sequence != null) result.sequence = sequence;
    if (baseJson != null) result.baseJson = baseJson;
    if (incomingJson != null) result.incomingJson = incomingJson;
    return result;
  }

  SyncRequest._();

  factory SyncRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SyncRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'optosync.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'lane')
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'sequence', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'baseJson')
    ..aOS(4, _omitFieldNames ? '' : 'incomingJson')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncRequest copyWith(void Function(SyncRequest) updates) =>
      super.copyWith((message) => updates(message as SyncRequest))
          as SyncRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncRequest create() => SyncRequest._();
  @$core.override
  SyncRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SyncRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncRequest>(create);
  static SyncRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get lane => $_getSZ(0);
  @$pb.TagNumber(1)
  set lane($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLane() => $_has(0);
  @$pb.TagNumber(1)
  void clearLane() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get sequence => $_getI64(1);
  @$pb.TagNumber(2)
  set sequence($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSequence() => $_has(1);
  @$pb.TagNumber(2)
  void clearSequence() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get baseJson => $_getSZ(2);
  @$pb.TagNumber(3)
  set baseJson($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBaseJson() => $_has(2);
  @$pb.TagNumber(3)
  void clearBaseJson() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get incomingJson => $_getSZ(3);
  @$pb.TagNumber(4)
  set incomingJson($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIncomingJson() => $_has(3);
  @$pb.TagNumber(4)
  void clearIncomingJson() => $_clearField(4);
}

class SyncResponse extends $pb.GeneratedMessage {
  factory SyncResponse({
    $core.String? lane,
    $fixnum.Int64? sequence,
    $core.String? mergedJson,
    $core.String? coreVersion,
  }) {
    final result = create();
    if (lane != null) result.lane = lane;
    if (sequence != null) result.sequence = sequence;
    if (mergedJson != null) result.mergedJson = mergedJson;
    if (coreVersion != null) result.coreVersion = coreVersion;
    return result;
  }

  SyncResponse._();

  factory SyncResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SyncResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'optosync.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'lane')
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'sequence', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'mergedJson')
    ..aOS(4, _omitFieldNames ? '' : 'coreVersion')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncResponse copyWith(void Function(SyncResponse) updates) =>
      super.copyWith((message) => updates(message as SyncResponse))
          as SyncResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncResponse create() => SyncResponse._();
  @$core.override
  SyncResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SyncResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncResponse>(create);
  static SyncResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get lane => $_getSZ(0);
  @$pb.TagNumber(1)
  set lane($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLane() => $_has(0);
  @$pb.TagNumber(1)
  void clearLane() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get sequence => $_getI64(1);
  @$pb.TagNumber(2)
  set sequence($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSequence() => $_has(1);
  @$pb.TagNumber(2)
  void clearSequence() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get mergedJson => $_getSZ(2);
  @$pb.TagNumber(3)
  set mergedJson($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMergedJson() => $_has(2);
  @$pb.TagNumber(3)
  void clearMergedJson() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get coreVersion => $_getSZ(3);
  @$pb.TagNumber(4)
  set coreVersion($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCoreVersion() => $_has(3);
  @$pb.TagNumber(4)
  void clearCoreVersion() => $_clearField(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
