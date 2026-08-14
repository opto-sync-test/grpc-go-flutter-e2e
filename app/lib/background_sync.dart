import 'dart:async';
import 'dart:convert';

import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';

import 'gen/sync.pbgrpc.dart';

final class SyncLane {
  const SyncLane({
    required this.lane,
    required this.sequence,
    required this.base,
    required this.incoming,
  });

  final String lane;
  final int sequence;
  final Map<String, dynamic> base;
  final Map<String, dynamic> incoming;

  SyncRequest toRequest() => SyncRequest(
    lane: lane,
    sequence: Int64(sequence),
    baseJson: jsonEncode(base),
    incomingJson: jsonEncode(incoming),
  );

  Map<String, dynamic> toInput() => {
    'lane': lane,
    'sequence': sequence,
    'base': jsonEncode(base),
    'incoming': jsonEncode(incoming),
  };

  static SyncLane fromInput(Map<String, dynamic> input) => SyncLane(
    lane: input['lane'] as String,
    sequence: input['sequence'] as int,
    base: jsonDecode(input['base'] as String) as Map<String, dynamic>,
    incoming: jsonDecode(input['incoming'] as String) as Map<String, dynamic>,
  );
}

/// A bounded background cycle over one long-lived bidirectional gRPC stream.
///
/// Workmanager persists the serialized lane batch on mobile and web. If a
/// process or connection disappears before every `(lane, sequence)` is
/// acknowledged, the complete immutable batch is replayed on the next attempt.
/// The Go side is responsible for idempotent domain writes; this class refuses
/// partial or cross-lane acknowledgements.
final class MultiplexBackgroundSyncWorker {
  MultiplexBackgroundSyncWorker(
    this.client, {
    this.maxAttempts = 8,
    this.retryDelay = const Duration(milliseconds: 100),
    this.callTimeout = const Duration(seconds: 5),
  });

  final SyncServiceClient client;
  final int maxAttempts;
  final Duration retryDelay;
  final Duration callTimeout;

  Future<List<SyncResponse>> drain(List<SyncLane> lanes) async {
    if (lanes.isEmpty) return const [];
    final expected = {
      for (final lane in lanes) '${lane.lane}/${lane.sequence}',
    };
    if (expected.length != lanes.length) {
      throw ArgumentError('lane and sequence pairs must be unique');
    }

    Object? lastError;
    for (var attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        final responses = await client
            .sync(
              Stream<SyncRequest>.fromIterable(
                lanes.map((lane) => lane.toRequest()),
              ),
              options: CallOptions(timeout: callTimeout),
            )
            .toList();
        final acknowledged = {
          for (final response in responses)
            '${response.lane}/${response.sequence}',
        };
        if (responses.length != lanes.length ||
            acknowledged.length != expected.length ||
            !acknowledged.containsAll(expected)) {
          throw StateError(
            'the gRPC stream returned a partial or mismatched batch',
          );
        }
        return responses;
      } catch (error) {
        lastError = error;
        if (attempt < maxAttempts) await Future<void>.delayed(retryDelay);
      }
    }
    throw StateError(
      'background sync exhausted $maxAttempts attempts: $lastError',
    );
  }

  /// Keeps consuming browser, mobile, or desktop wake batches until the host
  /// lifecycle closes [wakes]. Each batch is independently replay-safe.
  Stream<List<SyncResponse>> run(Stream<List<SyncLane>> wakes) async* {
    await for (final lanes in wakes) {
      yield await drain(lanes);
    }
  }
}
