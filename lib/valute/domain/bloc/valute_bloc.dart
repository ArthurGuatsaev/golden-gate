import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../const/strings.dart';
import '../repository/valute_repository.dart';

part 'valute_event.dart';
part 'valute_state.dart';

class ValuteBloc extends Bloc<ValuteEvent, ValuteState> {
  final ValuteRepository repository;
  ValuteBloc({required this.repository}) : super(const ValuteState()) {
    on<GetValutePriceEvent>(getValutePrice);
    on<GetAllValutePriceEvent>(getAllValutePrice);
    on<UpdateAndSaveValutePairEvent>(updateAndSaveValutePair);
    on<AddAndSaveValutePairEvent>(addAndSaveValutePair);
    on<DeleteAndSaveValutePairEvent>(deleteAndSaveValutePair);
    on<InitLocalDataEvent>(initLocalData);
  }

  initLocalData(InitLocalDataEvent event, Emitter<ValuteState> emit) async {
    const valute = valuteList;
    emit(state.copyWith(valute: valute));
    add(GetValutePriceEvent());
  }

  getAllValutePrice(
      GetAllValutePriceEvent event, Emitter<ValuteState> emit) async {
    final pare = await Future.wait(await repository.getValute(valutePairList));
    emit(state.copyWith(allValutePair: pare));
  }

  addAndSaveValutePair(
      AddAndSaveValutePairEvent event, Emitter<ValuteState> emit) async {
    final pair = [...state.valutePair, event.pair];
    await repository.saveValute(pair.map((e) => e.pairValute).toList());
    emit(state.copyWith(valutePair: pair));
  }

  updateAndSaveValutePair(
      UpdateAndSaveValutePairEvent event, Emitter<ValuteState> emit) async {
    final pair = [...state.valutePair];
    pair.remove(event.pair);
    pair.insert(event.index, event.newPair);
    await repository.saveValute(pair.map((e) => e.pairValute).toList());
    emit(state.copyWith(valutePair: pair));
  }

  deleteAndSaveValutePair(
      DeleteAndSaveValutePairEvent event, Emitter<ValuteState> emit) async {
    final pair = [...state.valutePair];
    pair.remove(event.pair);
    await repository.saveValute(pair.map((e) => e.pairValute).toList());
    emit(state.copyWith(valutePair: pair));
  }

  getValutePrice(GetValutePriceEvent event, Emitter<ValuteState> emit) async {
    final valutePair = await repository.getValuteTitle();
    final pare = await Future.wait(await repository.getValute(valutePair));
    emit(state.copyWith(valutePair: pare));
  }
}
