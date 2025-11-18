import 'package:flutter/foundation.dart';

class DebugPrint {
  final dynamic value;
  final dynamic text;

  DebugPrint(this.value, this.text);

  void log() {
    final isEmpty = _checkEmpty(value);
    if (kDebugMode) {
      print(
        "\x1B[33m$text\x1B[0m: ${isEmpty ? '\x1B[31mFailed\x1B[0m' : '\x1B[32mSuccess\x1B[0m'}",
      );
    }
  }

  bool _checkEmpty(dynamic v) {
    if (v == null) return true;
    if (v is String) return v.trim().isEmpty;
    if (v is Iterable || v is Map) return v.isEmpty;
    if (v is List) return v.isEmpty;
    return false;
  }
}
