import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shadowinner_master_settings/constants.dart';
import 'package:shadowinner_master_settings/localization/string_hardcoded.dart';
import 'package:shadowinner_master_settings/screens/settings_master/components/departement_info_widget.dart';
import 'package:shadowinner_master_settings/screens/settings_master/components/labeled_dropdown_text_field_with_chip.dart';

class ShadowinnerSkillsStructureScreen extends StatefulWidget {
  const ShadowinnerSkillsStructureScreen({Key? key}) : super(key: key);

  @override
  State<ShadowinnerSkillsStructureScreen> createState() =>
      _ShadowinnerSkillsStructureScreenState();
}

class _ShadowinnerSkillsStructureScreenState
    extends State<ShadowinnerSkillsStructureScreen> {
  @override
  Widget build(BuildContext context) {
    // Map<String, List<String>>? shadowingSubjects = {};
    List<String> shadowingSubjects = [];
    List<String> departments = ["Sales", "Marketing", "Finance", "HR"];

    Map<String, List<String>> initializeSkillsPerDepartment(
        List<String> departmentList) {
      Map<String, List<String>> map = {}; // Specify the type here
      if (departmentList.isNotEmpty) {
        map = {for (var department in departmentList) department: <String>[]};
        debugPrint("map: $map");
        return map;
      } else {
        return {}; // You can also specify the type here, but it's not required.
      }
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Shadowing Subjects".hardcoded,
            style: GoogleFonts.dmSans(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: kPrimary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),
        DropdownFieldWithChips(
          initialChipsList: shadowingSubjects,
          initialChipsMap: initializeSkillsPerDepartment(departments),
          tooltipMessage:
              "Use the dropdown to select the department you want to add shadowing subjects for."
                  .hardcoded,
          onSubmitted: (text) {
            shadowingSubjects.add(text);
          },
          onDeleted: (text) {
            shadowingSubjects.remove(text);
          },
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "The 'Shadowing Subjects' you define for event sharing on Shadowinner must be specific to your company's professional activities.\n\nThese skills should be concrete and related to the tasks and responsibilities inherent to each department.\n\nThe goal is to allow employees to share events relevant to their daily work.\n\nTo define these skills, ask yourself the following questions:",
            style: GoogleFonts.dmSans(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.black, // Customize color as needed
            ),
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "1. Is this a necessary skill to perform the tasks of the department? "
                .hardcoded,
            style: GoogleFonts.dmSans(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Customize color as needed
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "Make sure that each skill you assign is essential for the team's success."
                .hardcoded,
            style: GoogleFonts.dmSans(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.black, // Customize color as needed
            ),
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "2. Can it be applied in a professional event?".hardcoded,
            style: GoogleFonts.dmSans(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Customize color as needed
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "Skills should be directly applicable to events like meetings, presentations, training, etc."
                .hardcoded,
            style: GoogleFonts.dmSans(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.black, // Customize color as needed
            ),
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "3. Are they specific and measurable?".hardcoded,
            style: GoogleFonts.dmSans(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Customize color as needed
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "Skills should be formulated in a way that makes it possible to determine whether an employee possesses them or not."
                .hardcoded,
            style: GoogleFonts.dmSans(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.black, // Customize color as needed
            ),
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(height: 20),
        const DepartmentInfoWidget(),
      ],
    );
  }
}
