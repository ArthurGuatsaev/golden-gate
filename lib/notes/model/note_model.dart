// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:isar/isar.dart';

part 'note_model.g.dart';

@collection
class VNotesIssar {
  Id id = Isar.autoIncrement;
  String? title;
  String? body;
  int? iD;
  DateTime? date;
  int get year {
    if (date == null) return 2023;
    final year = date!.year;
    return year;
  }

  @ignore
  String get dateString {
    final month =
        '${date!.month}'.length < 2 ? '0${date!.month}' : '${date!.month}';
    final day = '${date!.day}'.length < 2 ? '0${date!.day}' : '${date!.day}';
    return '$day.$month.${date!.year}';
  }
}
