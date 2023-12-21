// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'car_model.g.dart';

@collection
class CarModel {
  Id? id = Isar.autoIncrement;
  int? myId;
  String? name;
  double? price;
  String? desc;
  List<ExpensesModel>? expenses;
  String? image;
  bool? isFavorite;
  List<TenantModel>? tenants;
  CarModel({
    this.id,
    this.myId,
    this.name,
    this.expenses,
    this.price,
    this.desc,
    this.tenants,
    this.image,
    this.isFavorite,
  });

  CarModel copyWith({
    Id? id,
    int? myId,
    String? name,
    double? price,
    List<ExpensesModel>? expenses,
    String? desc,
    List<TenantModel>? tenants,
    String? image,
    bool? isFavorite,
  }) {
    return CarModel(
      id: id ?? this.id,
      expenses: expenses ?? this.expenses,
      myId: myId ?? this.myId,
      name: name ?? this.name,
      tenants: tenants ?? this.tenants,
      price: price ?? this.price,
      desc: desc ?? this.desc,
      image: image ?? this.image,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @ignore
  String get status {
    if (tenants == null || tenants!.isEmpty) {
      return 'No rented';
    }
    final today = DateTime.now();
    if (today.isAfter(tenants!.last.startDate!) &&
        today.isBefore(tenants!.last.finishDate!)) {
      return 'Rented';
    } else {
      return 'No rented';
    }
  }

  @ignore
  Future<FileImage?> get productImage async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final localPath = (prefs).getString('$myId');
      if (localPath == null) {
        return null;
      }
      final path = await getApplicationDocumentsDirectory();
      return FileImage(File(path.path + localPath));
    } catch (e) {
      return null;
    }
  }

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price'] != null ? map['price'] as double : null,
      desc: map['desc'] != null ? map['desc'] as String : null,
      isFavorite: map['isFavorite'] != null ? map['isFavorite'] as bool : null,
    );
  }
}

@embedded
class TenantModel {
  String? name;
  DateTime? startDate;
  DateTime? finishDate;
  @ignore
  String get date {
    return '${startDate!.day}.${startDate!.month}.${startDate!.year} - ${finishDate!.day}.${finishDate!.month}.${finishDate!.year}';
  }
}

@embedded
class ExpensesModel {
  String? name;
  DateTime? date;
  double? price;
}
