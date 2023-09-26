// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:shadowinner_master_settings/constants.dart';
// import 'package:shadowinner_master_settings/screens/settings_master/page_view/employees/employees_info_screen.dart';

// class ManualEmployee extends ConsumerWidget {
//   ManualEmployee({
//     super.key,
//     required this.businessRegions,
//     required this.countries,
//     required this.departments,
//     required this.teams,
//   });

//   bool isMasterUser = false;
//   List<String> businessRegions = [];
//   List<String> countries = [];
//   List<String> departments = [];
//   List<String> teams = [];
//   List<String> departmentList = ["HR", "Sales", "Finance", "IT"];
//   List<String> teamList = ["Team 1", "Team 2", "Team 3"];
//   List<String> countryList = ["France", "United States", "Canada"];
//   List<String> businessRegionList = ["EMEA", "North America", "Asia"];

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ListView(
//       shrinkWrap: true,
//       children: [
//         ListTile(
//           title: const Text("Email Address"),
//           subtitle: TextField(
//             controller: emailController,
//             keyboardType: TextInputType.emailAddress,
//           ),
//         ),
//         CustomDropdown<String>(
//           label: "Department ",
//           items: departmentList,
//           value: departments.isNotEmpty ? departments[0] : null,
//           onChanged: (value) {
//             setState(() {
//               departments.clear();
//               departments.add(value!);
//             });
//           },
//         ),
//         CustomDropdown<String>(
//           label: "Team ",
//           items: teamList,
//           value: teams.isNotEmpty ? teams[0] : null,
//           onChanged: (value) {
//             setState(() {
//               teams.clear();
//               teams.add(value!);
//             });
//           },
//         ),
//         CustomDropdown<String>(
//           label: "Country ",
//           items: countryList,
//           value: countries.isNotEmpty ? countries[0] : null,
//           onChanged: (value) {
//             setState(() {
//               countries.clear();
//               countries.add(value!);
//             });
//           },
//         ),
//         CustomDropdown<String>(
//           label: "Business Region ",
//           items: businessRegionList,
//           value: businessRegions.isNotEmpty ? businessRegions[0] : null,
//           onChanged: (value) {
//             setState(() {
//               businessRegions.clear();
//               businessRegions.add(value!);
//             });
//           },
//         ),
//         ListTile(
//           title: const Text("Language"),
//           subtitle: DropdownButton<String>(
//             value: selectedLanguage,
//             onChanged: (value) {
//               setState(() {
//                 selectedLanguage = value!;
//               });
//             },
//             items: ["English", "French"].map((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//           ),
//         ),
//         ListTile(
//           title: const Text("Is Master User"),
//           subtitle: Switch(
//             value: isMasterUser,
//             onChanged: (value) {
//               setState(() {
//                 isMasterUser = value;
//               });
//             },
//           ),
//         ),
//         // Add button to add the employees to the list
//         IconButton(
//           onPressed: () {
//             // Add your code to handle adding employees here
//           },
//           icon: const Icon(Icons.add),
//         ),
//         const SizedBox(height: 10),
//         // Text displaying employees already added
//         const Text(
//           "Employees already added:",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 5),
//         // Chips to represent added employees
//         Wrap(
//           children: [
//             Chip(
//               deleteButtonTooltipMessage: "Edit",
//               backgroundColor: kPrimary,
//               label: const Text("Employee 1", style: TextStyle(color: kWhite)),
//               deleteIcon: const Icon(
//                 Icons.edit,
//                 size: 20,
//                 color: kWhite,
//               ),
//               onDeleted: () {
//                 // Add your code to delete the employee here
//               },
//             ),
//             Chip(
//               label: const Text("Employee 2"),
//               onDeleted: () {
//                 // Add your code to delete the employee here
//               },
//             ),
//             // Add more chips as needed
//           ],
//         ),
//       ],
//     );
//   }
// }
