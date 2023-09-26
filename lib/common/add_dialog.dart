import 'package:flutter/material.dart';
import 'package:shadowinner_master_settings/constants.dart';

Future<void> addDialog(
  BuildContext context, {
  required String title,
  required Widget child,
  required Function() onAdd,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: kPrimary,
        ),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.2,
        child: child,
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(kPrimary),
          ),
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(kPrimary),
          ),
          child: const Text("Add"),
          onPressed: () {
            onAdd();
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}
