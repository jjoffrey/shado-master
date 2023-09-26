import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadowinner_master_settings/constants.dart';
import 'package:shadowinner_master_settings/localization/string_hardcoded.dart';
import 'package:shadowinner_master_settings/routing/app_router.dart';

/// Simple not found screen used for 404 errors (page not found on web)
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen(
      {super.key, this.errorMessage = '404 - Page not found!'});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              errorMessage.hardcoded,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: kBlack, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () => context.goNamed(AppRoute.home.name),
              child: Text(
                'Go home'.hardcoded,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: kBlack, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
