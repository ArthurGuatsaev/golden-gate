extension ToSymbol on String {
  String get toSymbol {
    final after = substring(4, 7);
    final befor = substring(0, 3);
    return '$befor$after';
  }
}

extension ToOneSymbol on String {
  String get toOneSymbol {
    return substring(0, 3);
  }
}

extension ToFirstLetter on String {
  String get toFirstLetter {
    final first = substring(0, 1);
    final after = substring(1);
    return first.toUpperCase() + after;
  }
}

extension DateFormatter on DateTime {
  String get dateString {
    final d = day.toString().length > 1 ? day.toString() : '0$month';
    final m = month.toString().length > 1 ? month.toString() : '0$month';
    return '$d.$m.$year';
  }
}

extension MonthString on int {
  String get monthString {
    switch (this) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return 'December';
    }
  }
}
