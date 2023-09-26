import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shadowinner_master_settings/common/async_value_widget.dart';
import 'package:shadowinner_master_settings/constants.dart';
import 'package:shadowinner_master_settings/localization/string_hardcoded.dart';
import 'package:shadowinner_master_settings/provider/company_provider.dart';
import 'package:shadowinner_master_settings/screens/settings_master/components/radio_button.dart';
import 'package:shadowinner_master_settings/screens/settings_master/components/text_field_multiple_chip.dart';

class OnboardingCompanyInfo extends ConsumerWidget {
  const OnboardingCompanyInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(companyControllerNotifierProvider),
      data: (company) => ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Welcome 👋".hardcoded,
              style: GoogleFonts.dmSans(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: kPrimary, // Customize color as needed
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Text("🎓"),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "To begin your journey on Shadowinner, we need a few information :"
                  .hardcoded,
              style: GoogleFonts.dmSans(
                fontSize: 25,
                fontWeight: FontWeight.normal,
                color: Colors.black, // Customize color as needed
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFieldMultipleChip(
              label: "Company Name".hardcoded,
              tooltipMessage: "Enter an unique company name",
              allowMultipleChips: false,
              onDeleted: (string) {
                print("onDeleted: $string");
                ref
                    .read(companyControllerNotifierProvider.notifier)
                    .changeCompanyName(string);
              },
              onSubmitted: (string) async {
                print("onSubmitted: $string");
                ref
                    .read(companyControllerNotifierProvider.notifier)
                    .changeCompanyName(string);
              },
              initialChips:
                  company.companyName == null || company.companyName == ""
                      ? []
                      : [company.companyName!],
            ),

            // TextField(
            //   onChanged: (text) {
            //     // Handle company name input
            //   },
            //   decoration: InputDecoration(
            //     labelText: "Company Name".hardcoded,
            //     border: const OutlineInputBorder(),
            //   ),
            // ),
          ),
          const SizedBox(height: 20), // Add spacing

          // New text and radio buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Choose the mail system used in your company:".hardcoded,
              style: GoogleFonts.dmSans(
                fontSize: 25,
                fontWeight: FontWeight.normal,
                color: Colors.black, // Customize color as needed
              ),
              textAlign: TextAlign.left,
            ),
          ),
          RadioTile(
              initialValue: company.mailSystem,
              onSelect: (MailSystem? value) {
                ref
                    .read(companyControllerNotifierProvider.notifier)
                    .changeMailSystem(value!);
              }),

          // Radio buttons for mail system choice

          const SizedBox(height: 30),
          //   const SizedBox(height: 30),
          //   Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Text(
          //       "In the following steps we will ask you about:".hardcoded,
          //       style: GoogleFonts.dmSans(
          //         fontSize: 16,
          //         fontWeight: FontWeight.normal,
          //         color: Colors.blue, // Customize color as needed
          //       ),
          //       textAlign: TextAlign.center,
          //     ),
          //   ),
          //   const SizedBox(height: 10),
          //   Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Text(
          //       "Company Structure: Details about your company's structure and organization."
          //           .hardcoded,
          //       style: GoogleFonts.dmSans(
          //         fontSize: 16,
          //         fontWeight: FontWeight.normal,
          //         color: Colors.black, // Customize color as needed
          //       ),
          //       textAlign: TextAlign.center,
          //     ),
          //   ),
          //   const SizedBox(height: 10),
          //   Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Text(
          //       "Company Skills: Skills and expertise within your company that you would like to use on Shadowinner for collaboration."
          //           .hardcoded,
          //       style: GoogleFonts.dmSans(
          //         fontSize: 16,
          //         fontWeight: FontWeight.normal,
          //         color: Colors.black, // Customize color as needed
          //       ),
          //       textAlign: TextAlign.center,
          //     ),
          //   ),
          //   const SizedBox(height: 10),
          //   Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Text(
          //       "Company Employees: Employees within your company that you would like to invite to Shadowinner."
          //           .hardcoded,
          //       style: GoogleFonts.dmSans(
          //         fontSize: 16,
          //         fontWeight: FontWeight.normal,
          //         color: Colors.black, // Customize color as needed
          //       ),
          //       textAlign: TextAlign.center,
          //     ),
          //   ),
          //   const SizedBox(height: 20),
          //   Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Text(
          //       "Note: The information you provide can be customized from the master user account."
          //           .hardcoded,
          //       style: GoogleFonts.dmSans(
          //         fontSize: 14,
          //         fontWeight: FontWeight.normal,
          //         color: Colors.grey, // Customize color as needed
          //       ),
          //       textAlign: TextAlign.center,
          //     ),
          //   ),
          // ],
        ],
      ),
    );
  }
}
