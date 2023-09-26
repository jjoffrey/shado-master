import 'package:flutter/material.dart';

enum MailSystem {
  microsoft,
  google,
}

class RadioTile extends StatefulWidget {
  RadioTile({required this.onSelect, required this.initialValue, super.key});
  //create an onTap function to pass the selected value to the parent widget
  Function(MailSystem? value) onSelect;
  MailSystem? initialValue;

  @override
  State<RadioTile> createState() => _RadioTileState();
}

class _RadioTileState extends State<RadioTile> {
  MailSystem? _character;

  @override
  void initState() {
    if (widget.initialValue != null) {
      _character = widget.initialValue;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Google'),
          leading: Radio<MailSystem>(
            value: MailSystem.google,
            groupValue: _character,
            onChanged: (MailSystem? value) {
              setState(() {
                _character = value;
                widget.onSelect(value);
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Microsoft'),
          leading: Radio<MailSystem>(
            value: MailSystem.microsoft,
            groupValue: _character,
            onChanged: (MailSystem? value) {
              setState(() {
                _character = value;
                widget.onSelect(value);
              });
            },
          ),
        ),
      ],
    );
  }
}
