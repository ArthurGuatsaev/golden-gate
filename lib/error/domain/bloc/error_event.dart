// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'error_bloc.dart';

abstract class ErrorEvent {}

class AddInitialEvent extends ErrorEvent {}

class CountInternetConnection extends ErrorEvent {}

class AddErrorEvent extends ErrorEvent {
  final String message;
  AddErrorEvent({
    required this.message,
  });
}
