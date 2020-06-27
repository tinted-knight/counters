import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'en.dart';
import 'fields.dart';
import 'ru.dart';

class AppLocalization {
  final Locale locale;

  AppLocalization(this.locale);

  static AppLocalization of(BuildContext context) {
    return Localizations.of(context, AppLocalization);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': en,
    'ru': ru,
  };

  String get debugError => _localizedValues[locale.languageCode][Fields.debugError];

  String get preset1Title => _localizedValues[locale.languageCode][Fields.preset1Title];

  String get preset2Title => _localizedValues[locale.languageCode][Fields.preset2Title];

  String get preset3Title => _localizedValues[locale.languageCode][Fields.preset3Title];

  String get preset4Title => _localizedValues[locale.languageCode][Fields.preset4Title];

  //=====================================

  String get appTitle => _localizedValues[locale.languageCode][Fields.appTitle];

  String get motivational1 => _localizedValues[locale.languageCode][Fields.motivational1];

  String get motivational2 => _localizedValues[locale.languageCode][Fields.motivational2];

  String get motivational3 => _localizedValues[locale.languageCode][Fields.motivational3];

  String get createCounter => _localizedValues[locale.languageCode][Fields.createCounter];

  String get title => _localizedValues[locale.languageCode][Fields.counterTitle];

  String get step => _localizedValues[locale.languageCode][Fields.counterStep];

  String get goal => _localizedValues[locale.languageCode][Fields.counterGoal];

  String get unit => _localizedValues[locale.languageCode][Fields.counterUnit];

  String get save => _localizedValues[locale.languageCode][Fields.actionSave];

  String get cancel => _localizedValues[locale.languageCode][Fields.actionCancel];

  String get back => _localizedValues[locale.languageCode][Fields.actionBack];

  String get delete => _localizedValues[locale.languageCode][Fields.actionDelete];

  String get stat => _localizedValues[locale.languageCode][Fields.stat];

  String get editTitle => _localizedValues[locale.languageCode][Fields.editTitle];

  String get pickColor => _localizedValues[locale.languageCode][Fields.pickColor];

  String get today => _localizedValues[locale.languageCode][Fields.today];

  String get ofGoal => _localizedValues[locale.languageCode][Fields.ofGoal];

  String get itemAlreadyExists =>
      _localizedValues[locale.languageCode][Fields.confirmationItemAlreadyExists];

  String get emptyChart => _localizedValues[locale.languageCode][Fields.emptyChart];

  String get chart => _localizedValues[locale.languageCode][Fields.chart];

  String get list => _localizedValues[locale.languageCode][Fields.list];

  String get addMissigValue => _localizedValues[locale.languageCode][Fields.addMissingValue];

  String get clearHistory => _localizedValues[locale.languageCode][Fields.clearHistory];

  String get up => _localizedValues[locale.languageCode][Fields.actionUp];

  String get down => _localizedValues[locale.languageCode][Fields.actionDown];

  String get reset => _localizedValues[locale.languageCode][Fields.actionReset];

  String get saving => _localizedValues[locale.languageCode][Fields.actionSaving];

  String get submit => _localizedValues[locale.languageCode][Fields.actionSubmit];

  String get dailyGoal => _localizedValues[locale.languageCode][Fields.dailyGoal];

  String get yes => _localizedValues[locale.languageCode][Fields.yes];

  String get no => _localizedValues[locale.languageCode][Fields.no];

  String get saveChanges => _localizedValues[locale.languageCode][Fields.confirmationSaveChanges];

  String get days7 => _localizedValues[locale.languageCode][Fields.days7];

  String get chooseDate => _localizedValues[locale.languageCode][Fields.chooseDate];

  String get fillAllMissing => _localizedValues[locale.languageCode][Fields.fillAllMissing];

  String get createFirstCounter => _localizedValues[locale.languageCode][Fields.createFirstCounter];

  String get confirmationCLearHistory =>
      _localizedValues[locale.languageCode][Fields.confirmationClearHistory];
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  @override
  bool isSupported(Locale locale) => ['en', 'ru'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) {
    return SynchronousFuture<AppLocalization>(AppLocalization(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}
