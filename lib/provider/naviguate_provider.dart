import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadowinner_master_settings/classes.dart';
import 'package:shadowinner_master_settings/screens/settings_master/components/radio_button.dart';

enum OnboardingScreenType {
  companyInfo,
  companyStructure,
  shadowinnerSkills,
  employees,
}

class NaviguateProvider extends ChangeNotifier {
  //build method to initialize the list of radio buttons

  build() {}

  PageController controller = PageController(initialPage: 0);

  int indexNumber(OnboardingScreenType type) {
    switch (type) {
      case OnboardingScreenType.companyInfo:
        return 0;
      case OnboardingScreenType.companyStructure:
        return 1;
      case OnboardingScreenType.shadowinnerSkills:
        return 2;
      case OnboardingScreenType.employees:
        return 3;
    }
  }

  void changePage(OnboardingScreenType type) {
    controller.animateToPage(indexNumber(type),
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    notifyListeners();
  }

  void previousPage() {
    controller.previousPage(
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    notifyListeners();
  }

  void nextPage() {
    controller.nextPage(
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    notifyListeners();
  }

  OnboardingScreenType getCurrentPage() {
    switch (controller.page) {
      case 0:
        return OnboardingScreenType.companyInfo;
      case 1:
        return OnboardingScreenType.companyStructure;
      case 2:
        return OnboardingScreenType.shadowinnerSkills;
      case 3:
        return OnboardingScreenType.employees;
      default:
        return OnboardingScreenType.companyInfo;
    }
  }
}

final apiNaviguateProvider = ChangeNotifierProvider<NaviguateProvider>((ref) {
  return NaviguateProvider();
});

final getCurrentPageProvider = Provider<OnboardingScreenType>((ref) {
  return ref.watch(apiNaviguateProvider).getCurrentPage();
});
