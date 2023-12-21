import 'dart:async';
import 'package:bloc/bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Timer? timer;
  HomeBloc() : super(const HomeState()) {
    on<ChangeHomeIndexEvent>(onChangeHomeIndex);
    on<ChangeTermsTestIndex>(onChangeTermsTestIndex);
    on<ActiveTestResultEvent>(onActiveTestResult);
    on<GetTermsEvent>(onGetTerms);
    on<StatusWinEvent>(onWinStatus);
    on<TestAgainEvent>(onTestAgain);
    on<NextLessonEvent>(onNextLesson);
    on<ChangeLessonsIndex>(onChangeLessonsIndex);
  }

  onChangeHomeIndex(ChangeHomeIndexEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(homeIndex: event.homeIndex));
  }

  onChangeLessonsIndex(ChangeLessonsIndex event, Emitter<HomeState> emit) {
    emit(state.copyWith(lessonsIndex: event.index));
  }

  onNextLesson(NextLessonEvent event, Emitter<HomeState> emit) {
    final index = state.lessonsIndex;
    if (index == 2) {
      return emit(state.copyWith(lessonsIndex: 0));
    }
    emit(state.copyWith(lessonsIndex: state.lessonsIndex + 1));
  }

  onChangeTermsTestIndex(ChangeTermsTestIndex event, Emitter<HomeState> emit) {
    if (event.next) {
      if (state.termsItemIndex == 5) {
        if (!state.activeTest.every((element) => true)) {
          timer!.cancel();
          add(const StatusWinEvent(status: MyTestStatus.win));
        } else {
          timer!.cancel();
          add(const StatusWinEvent(status: MyTestStatus.lose));
        }
        return emit(state.copyWith(termsItemIndex: 0));
      }
      ;
      emit(state.copyWith(termsItemIndex: state.termsItemIndex + 1));
    } else {
      if (state.termsItemIndex == 0) return;
      emit(state.copyWith(termsItemIndex: state.termsItemIndex - 1));
    }
  }

  onTestAgain(TestAgainEvent event, Emitter<HomeState> emit) {
    timer = Timer(const Duration(seconds: 60), () {
      if (!state.activeTest.every((element) => true)) {
        add(const StatusWinEvent(status: MyTestStatus.win));
      } else {
        add(const StatusWinEvent(status: MyTestStatus.lose));
      }
    });
    emit(state.copyWith(testStatus: MyTestStatus.start));
  }

  onWinStatus(StatusWinEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(testStatus: event.status));
    emit(state.copyWith(testStatus: MyTestStatus.initial, termsItemIndex: 0));
  }

  onGetTerms(GetTermsEvent event, Emitter<HomeState> emit) async {
    // final terms = termsListInitial;
    // emit(state.copyWith(terms: terms));
  }

  onActiveTestResult(ActiveTestResultEvent event, Emitter<HomeState> emit) {
    final right = (event.result == true && state.test[event.index] == 0) ||
        (event.result == false && state.test[event.index] == 1);
    if (event.index < state.activeTest.length) {
      final newResult = [...state.activeTest];
      newResult.removeAt(event.index);
      newResult.insert(event.index, right);
      return emit(state.copyWith(activeTest: newResult));
    }
    final newResult = [...state.activeTest];
    newResult.add(right);
    emit(state.copyWith(activeTest: newResult));
  }

  onChangeViewAll(ChangeViewAllEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(viewAll: !state.viewAll));
  }
}
