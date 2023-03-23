import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// Translation Service
///
///
class TranslationService {
  static TranslationService get instance => _instance ??= TranslationService();
  static TranslationService? _instance;

  final DocumentReference doc =
      SystemSettingService.instance.col.doc('translations');

  Map<String, dynamic> texts = {};

  TranslationService() {
    doc.snapshots().listen((snapshot) {
      if (!snapshot.exists) {
        return;
      }
      final data = snapshot.data() as Map<String, dynamic>;

      final ln =
          Localizations.localeOf(AppService.instance.context).languageCode;

      for (final code in data.keys) {
        final text = data[code] as Map<String, dynamic>;
        texts[code] = text[ln] ?? text['en'] ?? '';
      }
    });
  }

  init() {}

  /// Add a code to database.
  Future<void> add(String code) async {
    return doc.set(
      {
        code: {},
      },
      SetOptions(merge: true),
    );
  }

  /// Get a text by code.
  String get(String code) {
    final dynamic text = texts[code] ?? code;
    if (text! is String) {
      return text.toString();
    } else {
      return text;
    }
  }
}
