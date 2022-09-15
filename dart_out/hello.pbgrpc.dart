///
//  Generated code. Do not modify.
//  source: hello.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'hello.pb.dart' as $0;
export 'hello.pb.dart';

class HelloClient extends $grpc.Client {
  static final _$echo = $grpc.ClientMethod<$0.Input, $0.Output>(
      '/hello.Hello/Echo',
      ($0.Input value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Output.fromBuffer(value));

  HelloClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Output> echo($0.Input request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$echo, request, options: options);
  }
}

abstract class HelloServiceBase extends $grpc.Service {
  $core.String get $name => 'hello.Hello';

  HelloServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Input, $0.Output>(
        'Echo',
        echo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Input.fromBuffer(value),
        ($0.Output value) => value.writeToBuffer()));
  }

  $async.Future<$0.Output> echo_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Input> request) async {
    return echo(call, await request);
  }

  $async.Future<$0.Output> echo($grpc.ServiceCall call, $0.Input request);
}
