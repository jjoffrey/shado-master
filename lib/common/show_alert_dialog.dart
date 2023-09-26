import 'package:flutter/material.dart';
import 'package:shadowinner_master_settings/constants.dart';

Future<bool?> showAlertDialog(
  BuildContext context, {
  required String title,
  required String content,
  String? cancelActionText,
  required String defaultActionText,
}) {
  return showDialog<bool?>(
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
        child: Text(
          content,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: kPrimary,
          ),
        ),
      ),
      actions: <Widget>[
        if (cancelActionText != null)
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(kPrimary),
            ),
            child: Text(cancelActionText),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(kPrimary),
          ),
          child: Text(defaultActionText),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    ),
  );
}
