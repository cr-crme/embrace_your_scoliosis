import '../models/locale_text.dart';
import 'package:flutter/material.dart';

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

    Navigator.of(context).pop(_password);
  }

  String? _validatePassword(String? value) {
    final texts = LocaleText.of(context, listen: false);

    if (value == null || value.isEmpty) return texts.passwordHint;
    if (value.length < 6) {
      return texts.passwordRules;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final texts = LocaleText.of(context, listen: false);

    return AlertDialog(
      title: Text(texts.changeYourPassword),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: texts.newPassword),
                validator: _validatePassword,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.visiblePassword,
                onSaved: (value) => _password = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: texts.copyPassword),
                validator: (value) => value == null || value.isEmpty
                    ? texts.copyPasswordHint
                    : (value != _password ? texts.copyPasswordError : null),
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
          child: Text(texts.save),
          onPressed: () => _finalize(),
        ),
      ],
    );
  }
}
