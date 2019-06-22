import 'package:dio/dio.dart';

typedef Future<bool> RetryEvaluator(DioError error);

class RetryOptions {
  /// The number of retry in case of an error
  final int retries;

  /// The interval before a retry.
  final Duration retryInterval;

  /// Evaluating if a retry is necessary.regarding the error
  final RetryEvaluator retryEvaluator;

  const RetryOptions(
      {this.retries = 3,
      this.retryEvaluator,
      this.retryInterval = const Duration(seconds: 1)})
      : assert(retries != null),
        assert(retryInterval != null);

  factory RetryOptions.noRetry() {
    return RetryOptions(
      retries: 0,
    );
  }

  static const extraKey = "cache_retry_request";

  factory RetryOptions.fromExtra(RequestOptions request) {
    return request.extra[extraKey];
  }

  RetryOptions copyWith({
    int retries,
    Duration retryInterval,
  }) =>
      RetryOptions(
        retries: retries ?? this.retries,
        retryInterval: retryInterval ?? this.retryInterval,
      );

  Map<String, dynamic> toExtra() {
    return {
      extraKey: this,
    };
  }
}