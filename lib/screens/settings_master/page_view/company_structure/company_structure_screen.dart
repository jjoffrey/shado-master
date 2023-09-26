import 'package:flutter/material.dart';
import 'package:shadowinner_master_settings/constants.dart';
import 'package:shadowinner_master_settings/localization/string_hardcoded.dart';
import 'package:shadowinner_master_settings/screens/settings_master/components/text_field_multiple_chip.dart';

class OnboardingCompanyStructure extends StatefulWidget {
  const OnboardingCompanyStructure({Key? key}) : super(key: key);

  @override
  _OnboardingCompanyStructureState createState() =>
      _OnboardingCompanyStructureState();
}

class _OnboardingCompanyStructureState
    extends State<OnboardingCompanyStructure> {
  List<String> businessRegions = [];

  List<String> countries = [];

  List<String> departments = [];

  List<String> teams = [];

  bool showBusinessRegionChip = false;
  bool showCountryChip = false;
  bool showDepartmentChip = false;
  bool showTeamChip = false;

  @override
  Widget build(BuildContext context) {
    // teams = initializeTeamsPerDepartment(departments);
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Company Structure",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: kPrimary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "By adding the following information, you have more control over Shadowinner.\n\nImproving your experience by filtering and organizing your company's structure.\n\nThis allows you to tailor your interactions and content within the app."
                .hardcoded,
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.normal, color: kPrimary),
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(height: 10),
        TextFieldMultipleChip(
          initialChips: businessRegions,
          label: "Business Region (optionnal)".hardcoded,
          tooltipMessage:
              "Enter the business region where your company operates. For example, 'EMEA, North America'."
                  .hardcoded,
          onSubmitted: (text) {
            businessRegions.add(text);
          },
          onDeleted: (text) {
            businessRegions.remove(text);
          },
        ),
        TextFieldMultipleChip(
          initialChips: countries,
          label: "Country (optionnal)".hardcoded,
          tooltipMessage:
              "Enter the countries where your company operates. For example, 'France, United States'"
                  .hardcoded,
          onSubmitted: (text) {
            countries.add(text);
          },
          onDeleted: (text) {
            countries.remove(text);
          },
        ),
        TextFieldMultipleChip(
          initialChips: departments,
          label: "Department (recommended)".hardcoded,
          tooltipMessage:
              "Enter the departments within your company. For example, 'Sales', 'HR'"
                  .hardcoded,
          onSubmitted: (text) {
            departments.add(text);
          },
          onDeleted: (text) {
            departments.remove(text);
          },
        ),
        TextFieldMultipleChip(
          initialChips: teams,
          label: "Team (optionnal)".hardcoded,
          tooltipMessage:
              "Enter the teams within your company. For example, 'Team 1', 'Team 2'"
                  .hardcoded,
          onSubmitted: (text) {
            teams.add(text);
          },
          onDeleted: (text) {
            teams.remove(text);
          },
        ),
      ],
    );
  }
}
