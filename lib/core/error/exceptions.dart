import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String? message;
  final int? statusCode;
  const ServerException({this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

class CacheException extends Equatable implements Exception {
  final String? message;
  const CacheException({this.message});

  @override
  List<Object?> get props => [message];
}
