# Embrace your scoliosis

## Installation

The following steps are mandatory for running the apps

### Submodules Git
Make sure you have initialized the git modules

```bash
git submodule update --init
```

### Firebase

1. Install the [CLI Firebase](https://firebase.google.com/docs/cli#setup_update_cli). The easiest is to install it using `npm` from `Node.js`:    

```bash
npm install -g firebase-tools
```

2. Install the [CLI FlutterFire](https://pub.dev/packages/flutterfire_cli) using `dart`.

```bash
dart pub global activate flutterfire_cli
```

3. Connecter with your credential to the previously created firebase project (https://firebase.google.com/docs/flutter/setup) with the name `embraceYourScoliosis`. This must 

```bash
firebase login

cd clinician_app
firebase init
flutterfire configure --project=embraceyourscoliosis-456b1

cd ../patient_app
firebase init
flutterfire configure --project=embraceyourscoliosis-456b1
```

### Firebase Emulators

During the debug phase, it is convenient to rely on the firebase emulator instead of the actual database. To do so, you can either:

1. Run the debugger as usual (`F5`), assuming you have the .vscode configured.
2. Launch the emulator by typing the following command : `firebase emulators:start`
