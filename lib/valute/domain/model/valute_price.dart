class ValutePriceModel {
  final double? price;
  final double? change;
  ValutePriceModel({
    this.change,
    this.price,
  });

  factory ValutePriceModel.fromMap(Map<String, dynamic> map) {
    return ValutePriceModel(
      change: map['resultChangeInPercent'] != null
          ? map['resultChangeInPercent'] as double
          : null,
      price: map['resultPrice'] != null ? map['resultPrice'] as double : 0,
    );
  }
}

extension on String {
  DateTime get toTime {
    final x = indexOf('2023') + 5;
    final hours = substring(x, x + 2);
    final minuts = substring(x + 3, x + 5);
    final seconds = substring(x + 6, x + 8);
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, int.parse(hours),
        int.parse(minuts), int.parse(seconds));
  }
}
