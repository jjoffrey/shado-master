import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadowinner_master_settings/constants.dart';
import 'package:shadowinner_master_settings/services/auth.dart';
import 'package:url_launcher/url_launcher.dart';

class EmployeesScreen extends ConsumerStatefulWidget {
  const EmployeesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends ConsumerState<EmployeesScreen> {
  List<String> businessRegions = [];
  List<String> countries = [];
  List<String> departments = [];
  List<String> teams = [];

  bool showBusinessRegionChip = false;
  bool showCountryChip = false;
  bool showDepartmentChip = false;
  bool showTeamChip = false;

  bool isMasterUser = false;
  String selectedLanguage = 'English';

  // Email address field controller
  final TextEditingController emailController = TextEditingController();

  // Dropdown menu items
  List<String> departmentList = ["HR", "Sales", "Finance", "IT"];
  List<String> teamList = ["Team 1", "Team 2", "Team 3"];
  List<String> countryList = ["France", "United States", "Canada"];
  List<String> businessRegionList = ["EMEA", "North America", "Asia"];

  final _kTabPages = <Widget>[
    const Center(child: Icon(Icons.cloud, size: 64.0, color: Colors.teal)),
    const Center(child: Icon(Icons.alarm, size: 64.0, color: Colors.cyan)),
    const Center(child: Icon(Icons.forum, size: 64.0, color: Colors.blue)),
  ];

  final _kTabs = <Tab>[
    const Tab(
        icon: Icon(
          Icons.cloud,
        ),
        text: 'Tab1'),
    const Tab(icon: Icon(Icons.alarm), text: 'Tab2'),
    const Tab(icon: Icon(Icons.forum), text: 'Tab3'),
  ];

  @override
  Widget build(BuildContext context) {
    final auth = ref.read(authProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Employees",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: kPrimary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: DefaultTabController(
            length: 3,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TabBar(
                    labelColor: kPrimary,
                    tabs: [
                      const Tab(
                          icon: Icon(
                            Icons.people,
                            color: kPrimary,
                          ),
                          text: 'Already added'),
                      // const Tab(
                      //     icon: Icon(Icons.edit, color: kPrimary),
                      //     text: 'Add manually'),
                      const Tab(
                          icon: Icon(Icons.view_list_rounded, color: kPrimary),
                          text: 'Add by bulk'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Center(child: Text("No employees have been added yet")),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  child: ListView(
                                    children: [
                                      ListTile(
                                        title: const Text("First Name"),
                                        subtitle: TextField(
                                          controller: emailController,
                                          keyboardType: TextInputType.name,
                                        ),
                                      ),
                                      ListTile(
                                        title: const Text("Last Name"),
                                        subtitle: TextField(
                                          controller: emailController,
                                          keyboardType: TextInputType.name,
                                        ),
                                      ),
                                      ListTile(
                                        title: const Text("Email Address"),
                                        subtitle: TextField(
                                          controller: emailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                        ),
                                      ),
                                      CustomDropdown<String>(
                                        label: "Department ",
                                        items: departmentList,
                                        value: departments.isNotEmpty
                                            ? departments[0]
                                            : null,
                                        onChanged: (value) {
                                          setState(() {
                                            departments.clear();
                                            departments.add(value!);
                                          });
                                        },
                                      ),
                                      CustomDropdown<String>(
                                        label: "Team ",
                                        items: teamList,
                                        value:
                                            teams.isNotEmpty ? teams[0] : null,
                                        onChanged: (value) {
                                          setState(() {
                                            teams.clear();
                                            teams.add(value!);
                                          });
                                        },
                                      ),
                                      CustomDropdown<String>(
                                        label: "Country ",
                                        items: countryList,
                                        value: countries.isNotEmpty
                                            ? countries[0]
                                            : null,
                                        onChanged: (value) {
                                          setState(() {
                                            countries.clear();
                                            countries.add(value!);
                                          });
                                        },
                                      ),
                                      CustomDropdown<String>(
                                        label: "Business Region ",
                                        items: businessRegionList,
                                        value: businessRegions.isNotEmpty
                                            ? businessRegions[0]
                                            : null,
                                        onChanged: (value) {
                                          setState(() {
                                            businessRegions.clear();
                                            businessRegions.add(value!);
                                          });
                                        },
                                      ),
                                      ListTile(
                                        title: const Text("Language"),
                                        subtitle: DropdownButton<String>(
                                          value: selectedLanguage,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedLanguage = value!;
                                            });
                                          },
                                          items: ["English", "French"]
                                              .map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      ListTile(
                                        title: const Text("Is Master User"),
                                        subtitle: Switch(
                                          value: isMasterUser,
                                          onChanged: (value) {
                                            setState(() {
                                              isMasterUser = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                       
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "Import from an Excel File",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    color: kPrimary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: kPrimary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () async {
                                      Uri url = Uri.parse(
                                          "https://docs.google.com/spreadsheets/d/1y1hFuH1gwP52I14hHd6PNYRoTc4KYGgf/edit?usp=drive_link&ouid=114448344681485681552&rtpof=true&sd=true");
                                      await launchUrl(url);
                                    },
                                    child: const Text("Download Template")),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      auth.openFilePicker();
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              kPrimary, // Change the color as needed
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: const Column(
                                        children: [
                                          Icon(
                                            Icons
                                                .cloud_upload, // Use an appropriate cloud icon
                                            size:
                                                70.0, // Adjust the size as needed
                                            color:
                                                kPrimary, // Change the color as needed
                                          ),
                                          Text(
                                            "Upload your Excel file here (max 5 MB)",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color:
                                                  kPrimary, // Change the color as needed
                                              fontSize:
                                                  16.0, // Adjust the font size as needed
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDropdown<T> extends StatelessWidget {
  final String label;
  final List<T> items;
  final T? value;
  final void Function(T?) onChanged;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      subtitle: DropdownButton<T>(
        value: value,
        onChanged: onChanged,
        items: items.map((T item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(item.toString()),
          );
        }).toList(),
      ),
    );
  }
}
