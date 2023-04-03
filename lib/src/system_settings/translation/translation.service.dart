import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

/// 다국어 문자열 번역 서비스
///
/// Firestore 의 /system_settings/translations 에 보관되고, 실시간으로 업데이트 된다.
/// AppService 에 의해서 앱이 부팅 될 때 마다 자동으로 실행된다.
///
/// 현재 장치의 언어 코드(예: en, ko)에 해당하는 문자열을 사용한다.
///
class TranslationService {
  static TranslationService get instance =>
      _instance ??= TranslationService._();
  static TranslationService? _instance;

  final DocumentReference doc =
      SystemSettingService.instance.col.doc('translations');

  Map<String, dynamic> texts = {};

  final BehaviorSubject changes = BehaviorSubject.seeded(null);

  TranslationService._() {
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

      changes.add(null);
    });
  }

  init() {}

  /// Add a code to database.
  Future<void> add(String code) async {
    code = code.toLowerCase();
    return doc.set(
      {
        code: {},
      },
      SetOptions(merge: true),
    );
  }

  /// 입력된 code 의 다국어 문자열
  ///
  /// 문자열 코드를 입력하면, 번역된 문자열을 반환한다.
  ///
  /// 만약, 번역된 문자열이 없으면, 기본 값인 initialValue 를 반환한다.
  /// 특히, AppService 에서 번역된 문자열을 로드하기 전에 홈 화면이 먼저 보여지면, 번역된 문자열이 없을 수 있다.
  /// 이 때, initialValue 를 사용하면, 기본 문자열을 보여줄 수 있다.
  String get(
    String code, {
    String? initialValue,
    Map<String, String>? replace,
  }) {
    code = code.toLowerCase();
    String? text = texts[code];
    if (text == null) {
      text = initialValue ?? "[$code]";
    } else {
      text = text.toString();
    }

    if (replace != null) {
      for (final key in replace.keys) {
        text = text!.replaceAll('#$key', replace[key]!);
      }
    }

    return text!;
  }
}

/// 입력된 code 의 다국어 문자열
///
/// 문자열 코드를 입력하면, 번역된 문자열을 반환한다.
String ln(
  String code, {
  String? initialValue,
  Map<String, String>? replace,
}) =>
    TranslationService.instance.get(
      code,
      initialValue: initialValue,
      replace: replace,
    );

/// 문자열이 DB 에서 변경되면 Stream 으로 실시간으로 업데이트
///
/// 특히, AppService 가 늦게 번역된 문자열을 /system_settings/translation 에서 로드하는 경우,
/// 홈 화면에서, 번역된 문자열이 없을 수 있다. 이 때, 이 위젯을 통해 Stream 으로 업데이트하면 된다.
///
/// 문자열 코드를 입력하면, 번역된 문자열을 Text 위젯으로 반환한다.
///
/// 예
/// ```dart
/// const Ln('home', initialValue: 'HOME')
/// ```
class Ln extends StatelessWidget {
  const Ln(this.code, {super.key, this.initialValue, this.style});
  final String code;
  final String? initialValue;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        builder: (context, snapshot) {
          return Text(
            ln(code, initialValue: initialValue),
            style: style,
          );
        },
        stream: TranslationService.instance.changes);
  }
}
