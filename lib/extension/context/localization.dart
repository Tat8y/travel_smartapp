import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Create Extention for Localization
extension Localization on BuildContext {
  AppLocalizations? get loc => AppLocalizations.of(this);
}
