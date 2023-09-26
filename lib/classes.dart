// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shadowinner_master_settings/screens/settings_master/components/radio_button.dart';

enum Language {
  french,
  english,
}

class ShadowingSubjects {
  String name;
  String? department;
  ShadowingSubjects({
    required this.name,
    this.department,
  });
}

class Employees {
  String firstName;
  String lastName;
  String email;
  String department;
  String team;
  String country;
  String businessRegion;
  Language language;
  bool isMasterUser;

  Employees({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.department,
    required this.team,
    required this.country,
    required this.businessRegion,
    required this.language,
    required this.isMasterUser,
  });

  static Employees fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return Employees(
      firstName: snapshot.get("firstName"),
      lastName: snapshot.get("lastName"),
      email: snapshot.get("email"),
      department: snapshot.get("department"),
      team: snapshot.get("team"),
      country: snapshot.get("country"),
      businessRegion: snapshot.get("businessRegion"),
      language: snapshot.get("language") == "french"
          ? Language.french
          : Language.english,
      isMasterUser: snapshot.get("isMasterUser"),
    );
  }

  @override
  String toString() {
    return 'Employees(firstName: $firstName, lastName: $lastName, email: $email, department: $department, team: $team, country: $country, businessRegion: $businessRegion, language: $language, isMasterUser: $isMasterUser)';
  }
}

class Company {
  String? id;
  DateTime? creationDate;
  String? companyName;
  String? companyCode;
  List<String> owners;
  MailSystem? mailSystem;
  List<String>? businessRegions;
  List<String>? countries;
  List<String>? departments;
  List<String>? teams;
  List<ShadowingSubjects>? shadowingSubjects;
  List<Employees>? employees;

  Company({
    required this.id,
    required this.creationDate,
    required this.companyName,
    required this.companyCode,
    required this.owners,
    this.mailSystem,
    this.businessRegions,
    this.countries,
    this.departments,
    this.teams,
    this.shadowingSubjects,
    this.employees,
  });

  static Company fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map? data = snapshot.data() as Map?;

    if (data == null) {
      return Company(
        id: snapshot.id,
        creationDate: DateTime.now(),
        companyName: "",
        companyCode: "",
        owners: [],
      );
    }

    return Company(
      id: snapshot.id,
      creationDate: snapshot.get("creationDate").toDate(),
      companyName: snapshot.get("companyName"),
      companyCode: snapshot.get("companyCode"),
      owners: data.containsKey("owners")
          ? List<String>.from(snapshot.get("owners"))
          : [],
      mailSystem: data.containsKey("mailSystem")
          ? snapshot.get("mailSystem") == "MailSystem.google"
              ? MailSystem.google
              : MailSystem.microsoft
          : null,
      businessRegions: data.containsKey("businessRegions")
          ? List<String>.from(snapshot.get("businessRegions"))
          : [],
      countries: data.containsKey("countries")
          ? List<String>.from(snapshot.get("countries"))
          : [],
      departments: data.containsKey("departments")
          ? List<String>.from(snapshot.get("departments"))
          : [],
      teams: data.containsKey("teams")
          ? List<String>.from(snapshot.get("teams"))
          : [],
      shadowingSubjects: data.containsKey("shadowingSubjects")
          ? List<ShadowingSubjects>.from(
              snapshot.get("shadowingSubjects").map(
                    (x) => ShadowingSubjects(
                      name: x["name"],
                      department: x["department"],
                    ),
                  ),
            )
          : [],
    );
  }

  @override
  String toString() {
    return 'Company(id: $id, creationDate: $creationDate, companyName: $companyName, companyCode: $companyCode, owners: $owners, mailSystem: $mailSystem, businessRegions: $businessRegions, countries: $countries, departments: $departments, teams: $teams, shadowingSubjects: $shadowingSubjects, employees: $employees)';
  }
}

class MasterUser {
  String id;
  String companyName;
  String companyCode;
  DateTime? lastUpdate;

  MasterUser({
    required this.id,
    required this.companyName,
    required this.companyCode,
    required this.lastUpdate,
  });

  static MasterUser fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map? data = snapshot.data() as Map?;
    //convert data to map

    if (data == null) {
      return MasterUser(
        id: snapshot.id,
        companyName: "",
        companyCode: "",
        lastUpdate: DateTime.now(),
      );
    } else {
      return MasterUser(
        id: snapshot.id,
        companyName: data["companyName"],
        companyCode: data["companyCode"],
        lastUpdate: data.containsKey("lastUpdate") ? data["lastUpdate"] : null,
      );
    }
  }

  @override
  String toString() {
    return 'MasterUser(id: $id, companyName: $companyName, companyCode: $companyCode, lastUpdate: $lastUpdate)';
  }
}
