// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'car_bloc.dart';

abstract class CarEvent extends Equatable {
  const CarEvent();

  @override
  List<Object> get props => [];
}

class GetNFTEvent extends CarEvent {}

class UpdateNFTEvent extends CarEvent {}

class GetSaveNFTEvent extends CarEvent {}

class ReseteSaveNFTEvent extends CarEvent {}

class ChooseNFTEvent extends CarEvent {}

class CancelImageEvent extends CarEvent {}

class SaveNFTEvent extends CarEvent {
  final CarModel model;
  const SaveNFTEvent({
    required this.model,
  });
}

class RemoveNFTEvent extends CarEvent {
  final CarModel model;
  const RemoveNFTEvent({
    required this.model,
  });
}

class ChangeIndexEvent extends CarEvent {
  final CarModel index;
  const ChangeIndexEvent({
    required this.index,
  });
}

class ChangeStateImageEvent extends CarEvent {
  final Future<FileImage?> file;
  const ChangeStateImageEvent({
    required this.file,
  });
}
