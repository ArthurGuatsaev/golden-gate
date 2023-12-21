import 'dart:async';
import 'package:bloc/bloc.dart';

import '../../../nav_manager.dart';
part 'error_event.dart';
part 'error_state.dart';

class ErrorBloc extends Bloc<ErrorEvent, ErrorState> {
  final StreamController<String> errorController;
  ErrorBloc({required this.errorController}) : super(ErrorState()) {
    errorController.stream.listen(
      (event) {
        if (event.contains('No internet')) add(CountInternetConnection());
        if (event.contains('No internet') &&
            state.countInternetConnection != 1) {
          return;
        }

        add(AddErrorEvent(message: event));
        add(AddInitialEvent());
      },
    );
    on<AddErrorEvent>(addErrorContent);
    on<AddInitialEvent>(addInitial);
    on<CountInternetConnection>(countInternetConnection);
  }
  addErrorContent(AddErrorEvent event, Emitter<ErrorState> emit) {
    emit(state.copyWith(status: ErrorStatus.upps, message: event.message));
    MyNavigatorManager.instance.errorPop(event.message);
  }

  addInitial(AddInitialEvent event, Emitter<ErrorState> emit) {
    emit(state.copyWith(status: ErrorStatus.none, message: ''));
  }

  countInternetConnection(
      CountInternetConnection event, Emitter<ErrorState> emit) {
    emit(state.copyWith(
        countInternetConnection: state.countInternetConnection + 1));
  }
}
