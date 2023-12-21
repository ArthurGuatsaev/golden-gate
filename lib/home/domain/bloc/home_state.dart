// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState {
  final bool isWorker;
  final int homeIndex;
  final int lessonsIndex;
  final int lessonsItemIndex;
  final int termsIndex;
  final int onboardIndex;
  final int termsItemIndex;
  final MyTestStatus testStatus;
  final List<int> test;

  final List<bool> activeTest;
  final bool isAHistory;
  final bool viewAll;
  const HomeState({
    this.isWorker = true,
    this.onboardIndex = 0,
    this.termsIndex = 0,
    this.termsItemIndex = 0,
    this.test = const [],
    this.lessonsIndex = 0,
    this.activeTest = const [],
    this.testStatus = MyTestStatus.initial,
    this.lessonsItemIndex = 0,
    this.viewAll = false,
    this.homeIndex = 0,
    this.isAHistory = true,
  });

  HomeState copyWith(
      {bool? isWorker,
      bool? viewAll,
      int? termsItemIndex,
      int? termsIndex,
      List<int>? test,
      int? onboardIndex,
      int? lessonsIndex,
      List<bool>? activeTest,
      MyTestStatus? testStatus,
      int? lessonsItemIndex,
      bool? isAHistory,
      int? homeIndex}) {
    return HomeState(
        termsIndex: termsIndex ?? this.termsIndex,
        isWorker: isWorker ?? this.isWorker,
        activeTest: activeTest ?? this.activeTest,
        onboardIndex: onboardIndex ?? this.onboardIndex,
        viewAll: viewAll ?? this.viewAll,
        test: test ?? this.test,
        testStatus: testStatus ?? this.testStatus,
        termsItemIndex: termsItemIndex ?? this.termsItemIndex,
        lessonsItemIndex: lessonsItemIndex ?? this.lessonsItemIndex,
        lessonsIndex: lessonsIndex ?? this.lessonsIndex,
        isAHistory: isAHistory ?? this.isAHistory,
        homeIndex: homeIndex ?? this.homeIndex);
  }
}

enum MyTestStatus { initial, start, win, lose }
