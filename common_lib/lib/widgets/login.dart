import 'package:ezlogin/ezlogin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/database.dart';

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
    final database = Provider.of<Database>(context, listen: false);
    final status = await database.login(
      username: _email!,
      password: _password!,
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
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please type your email'
                        : null,
                    onSaved: (value) => _email = value,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please type your password'
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
                    child: const Text('Connect'),
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

class ChangePasswordAlertDialog extends StatefulWidget {
  const ChangePasswordAlertDialog({
    super.key,
  });

  @override
  State<ChangePasswordAlertDialog> createState() =>
      _ChangePasswordAlertDialogState();
}

class _ChangePasswordAlertDialogState extends State<ChangePasswordAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _password;

  void _finalize() {
    _formKey.currentState!.save();
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }

    Navigator.pop(context, _password);
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please type a password';
    if (value.length < 6) {
      return 'The password must be at least six characters long';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Please, change your password'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'New password'),
                validator: _validatePassword,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.visiblePassword,
                onSaved: (value) => _password = value,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Copy the new password'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please copy the password'
                    : (value != _password
                        ? 'The two passwords must match'
                        : null),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.visiblePassword,
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Save'),
          onPressed: () => _finalize(),
        ),
      ],
    );
  }
}
