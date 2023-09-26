import 'package:flutter/material.dart';
import 'package:shadowinner_master_settings/constants.dart';
import 'package:shadowinner_master_settings/localization/string_hardcoded.dart';

class DepartmentInfoWidget extends StatelessWidget {
  const DepartmentInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        const Row(
          children: [
            Expanded(
              child: Text(
                "To assist you in defining these skills, consider creating specific skills for each department.\n\nClick the buttons for examples.",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              DepartmentButton(
                departmentName: "Example Sales Team".hardcoded,
                onPressed: () {
                  // Add your logic here for when the button is pressed.
                },
              ),
              DepartmentButton(
                departmentName: "Example Logistics Team".hardcoded,
                onPressed: () {
                  // Add your logic here for when the button is pressed.
                },
              ),
              DepartmentButton(
                departmentName: "Example Marketing Team".hardcoded,
                onPressed: () {
                  // Add your logic here for when the button is pressed.
                },
              ),
              DepartmentButton(
                departmentName: "Example IT Team".hardcoded,
                onPressed: () {
                  // Add your logic here for when the button is pressed.
                },
              ),
              DepartmentButton(
                departmentName: "Example HR Team".hardcoded,
                onPressed: () {
                  // Add your logic here for when the button is pressed.
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),

        // Additional text content goes here.
      ],
    );
  }
}

class DepartmentButton extends StatelessWidget {
  final String departmentName;
  final VoidCallback onPressed;

  DepartmentButton({
    super.key,
    required this.departmentName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: onPressed,
        child: Text(departmentName, style: const TextStyle(color: kPrimary)),
      ),
    );
  }
}
