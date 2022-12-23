import 'package:common_lib/models/enums.dart';
import 'package:common_lib/models/locale_text.dart';
import 'package:common_lib/models/main_user.dart';
import 'package:flutter/material.dart';

class NewClinicianDialog extends StatefulWidget {
  const NewClinicianDialog({
    super.key,
    required this.email,
  });

  final String email;

  @override
  State<NewClinicianDialog> createState() => _NewClinicianDialogState();
}

class _NewClinicianDialogState extends State<NewClinicianDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _firstName;
  String? _lastName;

  void _finalize() {
    _formKey.currentState!.save();
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }

    final newUser = MainUser(
        firstName: _firstName!,
        lastName: _lastName!,
        email: widget.email,
        shouldChangePassword: true,
        userType: UserType.clinician);

    Navigator.of(context).pop(newUser);
  }

  @override
  Widget build(BuildContext context) {
    final texts = LocaleText.of(context);

    return AlertDialog(
      title: Text(texts.fillYourInformation),
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
                  initialValue: widget.email,
                  enabled: false),
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
