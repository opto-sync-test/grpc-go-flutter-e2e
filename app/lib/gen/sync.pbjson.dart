// This is a generated file - do not edit.
//
// Generated from sync.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use healthRequestDescriptor instead')
const HealthRequest$json = {
  '1': 'HealthRequest',
};

/// Descriptor for `HealthRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List healthRequestDescriptor =
    $convert.base64Decode('Cg1IZWFsdGhSZXF1ZXN0');

@$core.Deprecated('Use healthResponseDescriptor instead')
const HealthResponse$json = {
  '1': 'HealthResponse',
  '2': [
    {'1': 'core_version', '3': 1, '4': 1, '5': 9, '10': 'coreVersion'},
  ],
};

/// Descriptor for `HealthResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List healthResponseDescriptor = $convert.base64Decode(
    'Cg5IZWFsdGhSZXNwb25zZRIhCgxjb3JlX3ZlcnNpb24YASABKAlSC2NvcmVWZXJzaW9u');

@$core.Deprecated('Use mergeRequestDescriptor instead')
const MergeRequest$json = {
  '1': 'MergeRequest',
  '2': [
    {'1': 'base_json', '3': 1, '4': 1, '5': 9, '10': 'baseJson'},
    {'1': 'incoming_json', '3': 2, '4': 1, '5': 9, '10': 'incomingJson'},
  ],
};

/// Descriptor for `MergeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mergeRequestDescriptor = $convert.base64Decode(
    'CgxNZXJnZVJlcXVlc3QSGwoJYmFzZV9qc29uGAEgASgJUghiYXNlSnNvbhIjCg1pbmNvbWluZ1'
    '9qc29uGAIgASgJUgxpbmNvbWluZ0pzb24=');

@$core.Deprecated('Use mergeResponseDescriptor instead')
const MergeResponse$json = {
  '1': 'MergeResponse',
  '2': [
    {'1': 'merged_json', '3': 1, '4': 1, '5': 9, '10': 'mergedJson'},
    {'1': 'core_version', '3': 2, '4': 1, '5': 9, '10': 'coreVersion'},
  ],
};

/// Descriptor for `MergeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mergeResponseDescriptor = $convert.base64Decode(
    'Cg1NZXJnZVJlc3BvbnNlEh8KC21lcmdlZF9qc29uGAEgASgJUgptZXJnZWRKc29uEiEKDGNvcm'
    'VfdmVyc2lvbhgCIAEoCVILY29yZVZlcnNpb24=');
