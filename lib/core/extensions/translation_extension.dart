import 'package:aid_humanity/core/utils/app_localization.dart';
import 'package:flutter/material.dart';

extension TranslationExtension on BuildContext {
  String translate(String key) => AppLocalizations.of(this)!.translate(key)!;
}
