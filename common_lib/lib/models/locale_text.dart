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
  String get connectingToDevice => {
        'en': 'Connecting to brace',
        'fr': 'Connexion avec le corset'
      }[language]!;
  String get collectingData => {
        'en': 'Collecting data\nfrom brace',
        'fr': 'Récupération des données\ndu corset'
      }[language]!;
  String get sendingToDatabase => {
        'en': 'Sending data\nto clinician',
        'fr': 'Envoi des données\nau clinicien'
      }[language]!;
  String get finalizingDataCollection =>
      {'en': 'Finalizing data collection', 'fr': 'Finalization'}[language]!;
  String get meanWearingTime => {
        'en': 'Brace mean wearing time',
        'fr': 'Temps de port moyen du corset'
      }[language]!;
  String get tellUsNowYouFeel => {
        'en': 'Tell us how you fell today',
        'fr': 'Dis-nous comment tu te sens'
      }[language]!;

  String get addNewPatient =>
      {'en': 'Add new patient', 'fr': 'Ajouter un patient'}[language]!;
  String get fillPatientInformation => {
        'en': 'Fill patient information',
        'fr': 'Entrer les informations du patient'
      }[language]!;
  String get fillYourInformation => {
        'en': 'Fill your information',
        'fr': 'Entrer vos informations'
      }[language]!;
  String get firstName => {'en': 'First name', 'fr': 'Prénom'}[language]!;
  String get lastName => {'en': 'Last name', 'fr': 'Nom'}[language]!;
  String get email => {'en': 'Email', 'fr': 'Courriel'}[language]!;
  String get changeYourPassword => {
        'en': 'Please change your password',
        'fr': 'Changer votre mot de passe'
      }[language]!;
  String get password => {'en': 'Password', 'fr': 'Mot de passe'}[language]!;
  String get newPassword =>
      {'en': 'New password', 'fr': 'Nouveau mot de passe'}[language]!;
  String get copyPassword =>
      {'en': 'Copy the password', 'fr': 'Copier le mot de passe'}[language]!;
  String get firstNameHint =>
      {'en': 'Add a first name', 'fr': 'Ajouter un prénom'}[language]!;
  String get lastNameHint =>
      {'en': 'Add a last name', 'fr': 'Ajouter un nom de famille'}[language]!;
  String get emailHint =>
      {'en': 'Add an email', 'fr': 'Ajouter un courriel'}[language]!;
  String get passwordHint => {
        'en': 'Please type a password',
        'fr': 'Taper votre mot de passe'
      }[language]!;
  String get passwordRules => {
        'en': 'The password must be at least six characters long',
        'fr': 'Le mot de passe doit être d\'au moins six caractères'
      }[language]!;
  String get copyPasswordHint => {
        'en': 'Please copy the password',
        'fr': 'Copier le mot de passe'
      }[language]!;
  String get copyPasswordError => {
        'en': 'The two passwords must match',
        'fr': 'Les mots de passe doivent correspondre'
      }[language]!;

  String get connect => {'en': 'Connect', 'fr': 'Connecter'}[language]!;
  String get cancel => {'en': 'Cancel', 'fr': 'Annuler'}[language]!;
  String get save => {'en': 'Save', 'fr': 'Enregistrer'}[language]!;

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
