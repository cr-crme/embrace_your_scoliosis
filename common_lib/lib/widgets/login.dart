import 'package:ezlogin/ezlogin.dart';
import 'package:flutter/material.dart';

import '../models/database.dart';
import '../models/locale_text.dart';
import '../models/main_user.dart';
import 'change_password_dialog.dart';
import 'new_clinician_dialog.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.targetRouteName});

  static const routeName = '/login-screen';
  final String targetRouteName;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  Future<EzloginStatus>? _futureStatus;

  Future<MainUser?> _registerNewClinician() async {
    return await showDialog<MainUser>(
        context: context, builder: (ctx) => NewClinicianDialog(email: _email!));
  }

  Future<String> _changePassword() async {
    final password = await showDialog<String>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return const ChangePasswordAlertDialog();
      },
    );
    return password!;
  }

  Future<EzloginStatus> _processConnexion() async {
    // Validate input
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return EzloginStatus.cancelled;
    }
    _formKey.currentState!.save();

    // Login with the Notifier
    final status = await Database.of(context).login(
      username: _email!,
      password: _password!,
      getNewUserInfo: _registerNewClinician,
      getNewPassword: _changePassword,
    );

    // Make sure the page is still on before using the context again
    if (!mounted) return status;

    // If it is successful, navigate to the next page
    if (status == EzloginStatus.success) {
      Navigator.of(context).pushReplacementNamed(widget.targetRouteName);
      return status;
    }

    // Show the error
    _showError(status);
    return status;
  }

  @override
  Widget build(BuildContext context) {
    final texts = LocaleText.of(context);

    return FutureBuilder<EzloginStatus>(
        future: _futureStatus,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: texts.email),
                    validator: (value) =>
                        value == null || value.isEmpty ? texts.emailHint : null,
                    onSaved: (value) => _email = value,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: texts.password),
                    validator: (value) => value == null || value.isEmpty
                        ? texts.passwordHint
                        : null,
                    onSaved: (value) => _password = value,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      _futureStatus = _processConnexion();
                      setState(() {});
                    },
                    child: Text(texts.connect),
                  )
                ],
              ),
            ),
          );
        });
  }

  void _showError(EzloginStatus status) {
    // Make sure there is an actual error message to show
    if (status == EzloginStatus.waitingForLogin ||
        status == EzloginStatus.success) {
      return;
    }

    late final String message;
    if (status == EzloginStatus.cancelled) {
      message = 'Connexion reset by peer';
    } else if (status == EzloginStatus.wrongUsername) {
      message = 'Wrong username';
    } else if (status == EzloginStatus.wrongPassword) {
      message = 'Wrong password';
    } else {
      message = 'Unrecognized error';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 5)),
    );
  }
}
