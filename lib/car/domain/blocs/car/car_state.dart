// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'car_bloc.dart';

class CarState {
  final List<CarModel> car;
  final XFile? image;
  final int current;
  final int currentFavorite;
  const CarState(
      {this.car = const [],
      this.current = 0,
      this.currentFavorite = 0,
      this.image});

  CarState copyWith({
    List<CarModel>? car,
    int? current,
    int? currentFavorite,
    XFile? image,
  }) {
    return CarState(
      image: image,
      car: car ?? this.car,
      current: current ?? this.current,
      currentFavorite: currentFavorite ?? this.currentFavorite,
    );
  }

  List<ExpensesModel> get allExpenses {
    List<ExpensesModel> list = [];
    for (var i in car) {
      i.expenses != null && i.expenses!.isNotEmpty
          ? list.addAll(i.expenses!)
          : null;
    }
    return list;
  }

  double get driverRented {
    if (car.isEmpty) return 0;
    List<double> list = [];
    for (var i in car) {
      i.tenants != null && i.tenants!.isNotEmpty
          ? list.add(i.price! * i.tenants!.length)
          : null;
    }
    if (list.isEmpty) return 0;
    return list.reduce((value, element) => value + element);
  }

  double get rented {
    if (allExpenses.isEmpty) return 0;
    return allExpenses
        .map((e) => e.price!)
        .toList()
        .reduce((value, element) => value + element);
  }

  List<CarModel> get favoritenft =>
      car.where((element) => element.isFavorite!).toList();

  int get summNFT {
    if (car.isEmpty) return 0;
    return car
        .map((e) => e.price)
        .toList()
        .reduce((value, element) => value! + element!)!
        .toInt();
  }

  Map<String, List<ExpensesModel>> get expMap {
    Map<String, List<ExpensesModel>> map = {};
    for (var i in allExpenses) {
      final listI = map['${i.date!.month.monthString} ${i.date!.day}'];
      if (listI != null) {
        listI.add(i);
        map['${i.date!.month.monthString} ${i.date!.day}'] = listI;
      } else {
        map['${i.date!.month.monthString} ${i.date!.day}'] = [i];
      }
    }
    return map;
  }
}
