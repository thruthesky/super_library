import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/enums/enums.dart';

String endRange(String str) {
  return '$str\uf8ff';
}

DateTime dateTimeOf(int? timestamp) {
  if (timestamp == null || timestamp == 0) return DateTime.now();
  if (timestamp < 0) {
    throw Exception('Timestamp cannot be negative');
  }
  if (timestamp < 10000000000) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }
  return DateTime.fromMillisecondsSinceEpoch(timestamp);
}

String shortDateTimeOf(DateTime date) {
  //
  final nowDate = DateTime.now();
  final isToday = date.year == nowDate.year &&
      date.month == nowDate.month &&
      date.day == nowDate.day;
  //
  if (isToday) {
    return DateFormat('h:mm a').format(date);
  } else {
    return DateFormat('MMM d, y').format(date);
  }
}

double depth(int n) {
  return n * 24.0;
}

List<int> generateEmptyList(int length) {
  return List.generate(length, (index) => index);
}

List<String> keys(dynamic json) {
  if (json == null) return [];
  return Map<String, dynamic>.from(json).keys.toList();
}

List<String> listStringToListImage(List<String>? stringList) {
  if (stringList == null) return [];

  return stringList;
}
