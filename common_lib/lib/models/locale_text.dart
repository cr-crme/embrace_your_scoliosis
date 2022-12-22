import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocaleText with ChangeNotifier {
  LocaleText({required this.language});

  void setLanguage(language) {
    this.language = language;
    notifyListeners();
  }

  String language;

  static LocaleText of(BuildContext context, {bool listen = true}) {
    return Provider.of<LocaleText>(context, listen: listen);
  }

  String get template => {'en': 'Template', 'fr': 'Canevas'}[language]!;

  String get title =>
      {'en': 'Enjoy Your Brace', 'fr': 'Aime ton corset'}[language]!;
  String get fetchingAndSedingData => {
        'en': 'Fetching and sending data',
        'fr': 'Récupération et envoi\ndes données'
      }[language]!;
  String get meanWearingTime => {
        'en': 'Brace mean wearing time',
        'fr': 'Temps de port moyen du corset'
      }[language]!;
  String get tellUsNowYouFeel => {
        'en': 'Tell us how you fell today',
        'fr': 'Dis-nous comment tu te sens'
      }[language]!;

  String get submit => {'en': 'Submit', 'fr': 'Soumettre'}[language]!;
  String get mean => {'en': 'mean:', 'fr': 'moyenne :'}[language]!;
  String get day => {'en': 'day', 'fr': 'jour'}[language]!;

  String get temperature =>
      {'en': 'Temperature', 'fr': 'Température'}[language]!;

  String get selectMood => {'en': 'Answer!', 'fr': 'Répondre!'}[language]!;
  String get feelingToday => {
        'en': 'How are you feeling today?',
        'fr': 'Comment te sens-tu ajourd\'hui?'
      }[language]!;
  String get emotion => {'en': 'Emotion', 'fr': 'Émotion'}[language]!;
  String get comfort => {'en': 'Comfort', 'fr': 'Confort'}[language]!;
  String get humidity => {'en': 'Humidity', 'fr': 'Humidité'}[language]!;
  String get autonony => {'en': 'Autonomy', 'fr': 'Autonomie'}[language]!;

  String get materialNowWore => {
        'en': 'The material was not wore',
        'fr': 'Matériel non porté'
      }[language]!;
  String get wearingTime =>
      {'en': 'Mean wearing time:', 'fr': 'Porté en moyenne :'}[language]!;

  String get notLicenced => {
        'en': 'You are not a licensed user.\nThis will be reported',
        'fr': 'Vous n\'êtes pas un utilisateur licensé.\nCeci sera rapporté'
      }[language]!;
}
