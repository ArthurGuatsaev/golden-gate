// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'product_model.g.dart';

@collection
class ProductModel {
  Id? id = Isar.autoIncrement;
  String? valute;
  String? name;
  double? price;
  int? amount;
  bool? isArchive;
  bool? isFavorite;
  String? tag;
  double? initialPrice;
  String? description;
  String? imagePath;
  DateTime? date;
  List<TransactionsHistory>? transactionsHistory;
  ProductModel(
      {this.amount,
      this.id,
      this.date,
      this.description,
      this.initialPrice,
      this.isArchive,
      this.isFavorite,
      this.imagePath,
      this.name,
      this.price,
      this.tag,
      this.transactionsHistory,
      this.valute});

  ProductModel copyWith({
    Id? id,
    String? valute,
    String? name,
    double? price,
    int? amount,
    String? tag,
    bool? isArchive,
    double? initialPrice,
    bool? isFavorite,
    String? description,
    String? imagePath,
    DateTime? date,
    List<TransactionsHistory>? transactionsHistory,
  }) {
    return ProductModel(
      id: id ?? this.id,
      valute: valute ?? this.valute,
      name: name ?? this.name,
      price: price ?? this.price,
      initialPrice: initialPrice ?? this.initialPrice,
      amount: amount ?? this.amount,
      isArchive: isArchive ?? this.isArchive,
      isFavorite: isFavorite ?? this.isFavorite,
      tag: tag ?? this.tag,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      date: date ?? this.date,
      transactionsHistory: transactionsHistory ?? this.transactionsHistory,
    );
  }

  @ignore
  Future<FileImage?> get productImage async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final localPath = (prefs).getString(name!);
      if (localPath == null) {
        return null;
      }
      final path = await getApplicationDocumentsDirectory();
      return FileImage(File(path.path + localPath));
    } catch (e) {
      return null;
    }
  }

  @ignore
  String get dateString {
    final month =
        '${date!.month}'.length < 2 ? '0${date!.month}' : '${date!.month}';
    final day = '${date!.day}'.length < 2 ? '0${date!.day}' : '${date!.day}';
    return '$day.$month.${date!.year}';
  }

  @ignore
  int get changePrice {
    if (transactionsHistory == null || transactionsHistory!.isEmpty) {
      return 0;
    }
    return price!.toInt() - initialPrice!.toInt();
  }

  @ignore
  int get totalPrice {
    return (amount! * price!).toInt();
  }
}

@embedded
class TransactionsHistory {
  DateTime? date;
  bool? bull;
  double? price;
  int? amount;
  String? description;
  TransactionsHistory(
      {this.date, this.bull, this.price, this.amount, this.description});
  String get dateString {
    final month =
        '${date!.month}'.length < 2 ? '0${date!.month}' : '${date!.month}';
    final day = '${date!.day}'.length < 2 ? '0${date!.day}' : '${date!.day}';
    return '$day.$month.${date!.year}';
  }
}
