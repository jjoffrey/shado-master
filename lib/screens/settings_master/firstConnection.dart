import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadowinner_master_settings/screens/settings_master/onboarding_screen.dart';

Future<dynamic> firstConnexion(
  BuildContext context,
) async {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Consumer(builder: (_, WidgetRef ref, __) {
      return OnboardingScreen();
    }),
  );
}
