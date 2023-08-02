# enjoy_your_brace_clinician

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Firebase

1. Installer le [CLI Firebase](https://firebase.google.com/docs/cli#setup_update_cli). La façon la plus rapide, si Node.js est déjà installé, est avec `npm` :    

        npm install -g firebase-tools

2. Installer le [CLI FlutterFire](https://pub.dev/packages/flutterfire_cli) à l'aide de `dart`.

        dart pub global activate flutterfire_cli

3. Se connecter avec un compte ayant accès au projet Firebase et configurer le projet avec les paramètres par défaut.

        firebase login
        flutterfire configure --project=embraceyourscoliosis-456b1

Pour plus d'informations, visitez [cette page](https://firebase.google.com/docs/flutter/setup).

### Firebase Emulators

L'application ne modifie pas directement les données contenues sur le Cloud. À la place, tout les composants Firebase sont connectés à un emulateur local.  
Il existe deux façons faciles de les démarrer :

1. Commencer à debogger avec VS Code (`F5` par défaut).
2. Via la ligne de commande : `firebase emulators:start`
