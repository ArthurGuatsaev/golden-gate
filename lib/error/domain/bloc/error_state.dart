// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'error_bloc.dart';

class ErrorState {
  final ErrorStatus status;
  final String message;
  final int countInternetConnection;
  ErrorState(
      {this.status = ErrorStatus.none,
      this.message = '',
      this.countInternetConnection = 0});

  ErrorState copyWith(
      {ErrorStatus? status, String? message, int? countInternetConnection}) {
    return ErrorState(
        status: status ?? this.status,
        message: message ?? this.message,
        countInternetConnection:
            countInternetConnection ?? this.countInternetConnection);
  }
}

enum ErrorStatus { none, upps }
