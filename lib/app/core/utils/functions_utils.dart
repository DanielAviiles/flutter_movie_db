import 'dart:async';
import 'dart:convert' as json;
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

void hideKeyBoard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

bool isNumeric(dynamic value) {
  // ignore: prefer_single_quotes
  if (<dynamic>[null, '', ""].contains(value)) {
    return false;
  }
  final num? n = num.tryParse(value.toString());
  return n != null;
}

String? uint8ListToBase64(Uint8List? uint8list, {String format = 'png'}) {
  try {
    if (uint8list != null) {
      final String base64String = json.base64Encode(uint8list);
      return 'data:image/$format;base64,$base64String';
    }
    return null;
  } catch (e) {
    return null;
  }
}

Uint8List? getBytesFromBase64(String? base64, {String format = 'png'}) {
  try {
    if (base64 != null) {
      final String base64Format =
          base64.replaceAll('data:image/$format;base64,', '');
      return json.base64Decode(base64Format);
    }
    return null;
  } catch (e) {
    return null;
  }
}

Future<ui.Image?> decodeImageFromBytes(Uint8List? uint8list) async {
  if (uint8list != null) {
    try {
      final Completer<ui.Image> completer = Completer<ui.Image>();
      ui.decodeImageFromList(uint8list, (ui.Image img) {
        return completer.complete(img);
      });
      final ui.Image img = await completer.future;
      return img;
    } catch (e) {
      print(e);
      return null;
    }
  }
  return null;
}

String generateRandomString(int len) {
  final Random r = Random();
  const String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List<String>.generate(
      len, (int index) => _chars[r.nextInt(_chars.length)]).join();
}

int roundValueUp(double value) {
  if (value <= 0) {
    return 0;
  } else {
    final String valor = value.toStringAsFixed(1).split('.')[0];
    final String round = '$valor.9';
    return double.parse(round).round();
  }
}
