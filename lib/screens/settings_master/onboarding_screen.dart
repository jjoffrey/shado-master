import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadowinner_master_settings/common/async_value_widget.dart';
import 'package:shadowinner_master_settings/common/show_alert_dialog.dart';
import 'package:shadowinner_master_settings/constants.dart';
import 'package:shadowinner_master_settings/localization/string_hardcoded.dart';
import 'package:shadowinner_master_settings/provider/company_provider.dart';
import 'package:shadowinner_master_settings/provider/naviguate_provider.dart';
import 'package:shadowinner_master_settings/screens/settings_master/components/progress_dots.dart';
import 'package:shadowinner_master_settings/screens/settings_master/components/radio_button.dart';
import 'package:shadowinner_master_settings/screens/settings_master/drawer.dart';
import 'package:shadowinner_master_settings/screens/settings_master/page_view/company_general/company_info_screen.dart';
import 'package:shadowinner_master_settings/screens/settings_master/page_view/company_structure/company_structure_screen.dart';
import 'package:shadowinner_master_settings/screens/settings_master/page_view/employees/employees_info_screen.dart';
import 'package:shadowinner_master_settings/screens/settings_master/page_view/shadowing_skills/shadowinner_skills_screen.dart';
import 'package:shadowinner_master_settings/services/auth.dart';

class OnboardingScreen extends ConsumerWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  bool isLastScreen = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> onBoardingListWidget = [
      const OnboardingCompanyInfo(),
      const OnboardingCompanyStructure(),
      const ShadowinnerSkillsStructureScreen(),
      const EmployeesScreen(),
    ];

    return AsyncValueWidget(
      value: ref.watch(companyControllerNotifierProvider),
      data: (company) => Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimary,
            title: Text(
                "Connected on ${ref.watch(authProvider).currentUser!.email!}"),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  bool? logOutConfirmation = await showAlertDialog(
                    context,
                    title: "Log out".hardcoded,
                    content: "Are you sure you want to log out?".hardcoded,
                    defaultActionText: "Log out".hardcoded,
                    cancelActionText: "Cancel".hardcoded,
                  );
                  if (logOutConfirmation == true) {
                    ref.read(authProvider).signOut();
                  }
                },
              )
            ],
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: kGrey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: PageView(
                      controller: ref.read(apiNaviguateProvider).controller,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        for (Widget widget in onBoardingListWidget) widget,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          //create an add floating action button in the middle of the screen
          drawer: const MyDrawer(),
          floatingActionButton: isLastScreen
              ? FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    if (ref.read(apiNaviguateProvider).controller.page ==
                        onBoardingListWidget.length - 1) {}
                  },
                  backgroundColor: kPrimary,
                  child: const Icon(Icons.add, color: Colors.white),
                )
              : const SizedBox.shrink(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: OnboardingWidget(
            noOfScreen: onBoardingListWidget.length,
            onBackPressed: () {
              ref.read(apiNaviguateProvider).previousPage();
              return true;
            },
            onNextPressed: () async {
              //Get the current page
              OnboardingScreenType currentPage =
                  ref.read(getCurrentPageProvider);
              //Check the current page if this is the first page

              // If ok, setCompanyDocument
              if (currentPage == OnboardingScreenType.companyInfo) {
                String? companyName = company.companyName;
                MailSystem? mailSystem = company.mailSystem;

                debugPrint("companyName: $companyName");
                debugPrint("mailSystem: $mailSystem");

                if (companyName == null) {
                  showAlertDialog(
                    context,
                    title: "Company name".hardcoded,
                    content:
                        "Please enter a company name to continue".hardcoded,
                    defaultActionText: "OK".hardcoded,
                  );
                  return false;
                }

                if (mailSystem == null) {
                  showAlertDialog(
                    context,
                    title: "Mail system".hardcoded,
                    content:
                        "Please choose a mail system to continue".hardcoded,
                    defaultActionText: "OK".hardcoded,
                  );
                  return false;
                }

                bool isCompanyDocumentCreated = await ref
                    .read(authProvider)
                    .setCompanyDocument(
                        companyName: companyName, mailSystem: mailSystem);

                if (isCompanyDocumentCreated) {
                  ref
                      .read(companyControllerNotifierProvider.notifier)
                      .changeCompanyName(companyName);
                  ref
                      .read(companyControllerNotifierProvider.notifier)
                      .changeMailSystem(mailSystem);

                  ref.read(apiNaviguateProvider).nextPage();
                }
              }

              ref.read(apiNaviguateProvider).nextPage();
              return true;
            },
          )),
    );
  }

  // //Lets write function to change next onboarding screen
  // void changeScreen(int nextScreenNo) {
  //   controller.animateToPage(nextScreenNo,
  //       duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  // }
}
