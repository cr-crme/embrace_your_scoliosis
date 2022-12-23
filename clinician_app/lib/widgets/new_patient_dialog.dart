import 'package:common_lib/models/enums.dart';
import 'package:common_lib/models/locale_text.dart';
import 'package:common_lib/models/main_user.dart';
import 'package:ezlogin/ezlogin.dart';
import 'package:flutter/material.dart';

class NewPatientDialog extends StatefulWidget {
  const NewPatientDialog({super.key});

  @override
  State<NewPatientDialog> createState() => _NewPatientDialogState();
}

class _NewPatientDialogState extends State<NewPatientDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _firstName;
  String? _lastName;
  String? _email;

  void _finalize({bool hasCancelled = false}) {
    if (hasCancelled) {
      Navigator.of(context).pop();
      return;
    }

    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    var user = MainUser(
      firstName: _firstName!,
      lastName: _lastName!,
      email: _email!,
      userType: UserType.patient,
      shouldChangePassword: true,
      id: emailToPath(_email!),
    );

    Navigator.of(context).pop(user);
  }

  @override
  Widget build(BuildContext context) {
    final texts = LocaleText.of(context);

    return AlertDialog(
      title: Text(texts.fillPatientInformation),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: texts.firstName),
                validator: (value) =>
                    value == null || value.isEmpty ? texts.firstNameHint : null,
                onSaved: (value) => _firstName = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: texts.lastName),
                validator: (value) =>
                    value == null || value.isEmpty ? texts.lastNameHint : null,
                onSaved: (value) => _lastName = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: texts.email),
                validator: (value) =>
                    value == null || value.isEmpty ? texts.emailHint : null,
                onSaved: (value) => _email = value,
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(texts.cancel,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary)),
          onPressed: () => _finalize(hasCancelled: true),
        ),
        TextButton(
          child: Text(texts.save,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary)),
          onPressed: () => _finalize(),
        ),
      ],
    );
  }
}
