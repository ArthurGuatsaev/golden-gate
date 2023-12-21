// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'valute_bloc.dart';

class ValuteState {
  final List<ValuteViewModel> valutePair;
  final List<ValuteViewModel> allValutePair;
  final List<String> valute;
  const ValuteState({
    this.valutePair = const [],
    this.allValutePair = const [],
    this.valute = const [],
  });

  ValuteState copyWith(
      {List<String>? valute,
      List<ValuteViewModel>? valutePair,
      FileImage? profileImage,
      List<ValuteViewModel>? allValutePair,
      bool? bull,
      int? balance}) {
    return ValuteState(
      valute: valute ?? this.valute,
      allValutePair: allValutePair ?? this.allValutePair,
      valutePair: valutePair ?? this.valutePair,
    );
  }
}

class ValuteViewModel {
  final String pairValute;
  final double changePrice;
  final double price;
  const ValuteViewModel({
    this.pairValute = '',
    this.changePrice = 0,
    this.price = 0,
  });

  ValuteViewModel copyWith({
    String? pairValute,
    double? changePrice,
    double? price,
  }) {
    return ValuteViewModel(
      pairValute: pairValute ?? this.pairValute,
      changePrice: changePrice ?? this.changePrice,
      price: price ?? this.price,
    );
  }
}
