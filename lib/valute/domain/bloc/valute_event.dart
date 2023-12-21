// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'valute_bloc.dart';

abstract class ValuteEvent extends Equatable {
  const ValuteEvent();

  @override
  List<Object> get props => [];
}

class AddAndSaveValutePairEvent extends ValuteEvent {
  final ValuteViewModel pair;
  const AddAndSaveValutePairEvent({
    required this.pair,
  });
}

class UpdateAndSaveValutePairEvent extends ValuteEvent {
  final ValuteViewModel pair;
  final ValuteViewModel newPair;
  final int index;
  const UpdateAndSaveValutePairEvent(
      {required this.pair, required this.newPair, required this.index});
}

class DeleteAndSaveValutePairEvent extends ValuteEvent {
  final ValuteViewModel pair;
  const DeleteAndSaveValutePairEvent({required this.pair});
}

class GetValutePriceEvent extends ValuteEvent {}

class GetAllValutePriceEvent extends ValuteEvent {}

class InitLocalDataEvent extends ValuteEvent {}
