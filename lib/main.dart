import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadowinner_master_settings/constants.dart';
import 'package:shadowinner_master_settings/firebase_options.dart';
import 'package:shadowinner_master_settings/localization/string_hardcoded.dart';
import 'package:shadowinner_master_settings/routing/app_router.dart';
import 'package:shadowinner_master_settings/screens/onboarding/onboarding.dart';
import 'package:url_strategy/url_strategy.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      theme: ThemeData(
        primaryColor: kPrimary,
        scaffoldBackgroundColor: Colors.white,
      ),
      color: kPrimary,
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      title: 'Shadowinner Master Settings'.hardcoded,
    );
  }
}

void main() async {
  setPathUrlStrategy();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  );

  runApp(const ProviderScope(child: App()));
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        final screenHeight = MediaQuery.of(context).size.height;

        return Onboarding(screenHeight: screenHeight);
      },
    );
  }
}
