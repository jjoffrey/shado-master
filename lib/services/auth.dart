import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shadowinner_master_settings/classes.dart';
import 'package:shadowinner_master_settings/screens/settings_master/components/radio_button.dart';

final firestoreInstance = FirebaseFirestore.instance;
final firebaseAuth = FirebaseAuth.instance;

class AuthBase extends ChangeNotifier {
  AuthBase(this.ref) : super();

  final Ref ref;

  User? get currentUser {
    return firebaseAuth.currentUser;
  }

  Stream<User?> authStateChanges() => firebaseAuth.authStateChanges();

  Stream<User?> userChanges() => firebaseAuth.userChanges();

  void signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: "No user found for that email.",
          timeInSecForIosWeb: 5,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          webPosition: "center",
          fontSize: 16.0,
          webBgColor: "#ff3333",
          webShowClose: true,
        );
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: "Wrong password provided for that user.",
          timeInSecForIosWeb: 5,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          webPosition: "center",
          fontSize: 16.0,
          webBgColor: "#ff3333",
          webShowClose: true,
        );
      } else if (e.code == 'invalid-login-credentials') {
        Fluttertoast.showToast(
          msg: "Invalid login credentials",
          timeInSecForIosWeb: 5,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          webPosition: "center",
          fontSize: 16.0,
          webBgColor: "#ff3333",
          webShowClose: true,
        );
      } else {
        Fluttertoast.showToast(
          msg: e.message.toString(),
          timeInSecForIosWeb: 5,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          webPosition: "center",
          fontSize: 16.0,
          webBgColor: "#ff3333",
          webShowClose: true,
        );
      }
    }
  }

  void createAnAccount(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        createUserDocument(email: email, userID: userCredential.user!.uid);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("${e.code} ${e.message}");
      Fluttertoast.showToast(
        msg: e.message.toString(),
        timeInSecForIosWeb: 5,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        webPosition: "center",
        fontSize: 16.0,
        webBgColor: "#ff3333",
        webShowClose: true,
      );
    }
  }

  Future<void> createUserDocument(
      {required String email, required String userID}) async {
    // Generate a random ID for the user document
    // Reference to the Firestore collection
    CollectionReference users = firestoreInstance.collection('users');

    // Create a new document with the user's email as the document ID
    await users.doc(userID).set({
      'email': email,
    });

    // print('User document created for $email with ID: $userId');
  }

  void signOut() {
    firebaseAuth.signOut();
  }

  Future<void> openFilePicker() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
        allowMultiple: false,
      );

      if (result != null) {
        Uint8List filePath = result.files.single.bytes!;
        _uploadFile(filePath);
      }
    } catch (e) {
      print('Error picking a file: $e');
    }
  }

  Future<void> _uploadFile(Uint8List file) async {
    // final file = File(filePath);

    //Convert Uint8List to File

    try {
      int sizeInBytes = file.lengthInBytes; //lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      if (sizeInMb > 5) {
        Fluttertoast.showToast(
          msg: "File size must be less than 5 MB",
          timeInSecForIosWeb: 5,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          webPosition: "center",
          fontSize: 16.0,
          webBgColor: "#ff3333",
          webShowClose: true,
        );
        return;
      }

      // Check if the selected file is an Excel file

      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('uploads/${DateTime.now().millisecondsSinceEpoch}.xlsx');

      final UploadTask uploadTask = storageReference.putData(file);

      TaskSnapshot task = await uploadTask.whenComplete(() {
        // Fluttertoast.showToast(
        //   msg: "File uploaded successfully",
        //   timeInSecForIosWeb: 5,
        //   toastLength: Toast.LENGTH_LONG,
        //   gravity: ToastGravity.SNACKBAR,
        //   webPosition: "center",
        //   fontSize: 16.0,
        //   webBgColor: "#00ff00",
        //   webShowClose: true,
        // );
      });

      // task.
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(
        msg: "Error uploading file, please try again",
        timeInSecForIosWeb: 5,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        webPosition: "center",
        fontSize: 16.0,
        webBgColor: "#ff3333",
        webShowClose: true,
      );
      return;
    }
  }

  void saveLocally(String key, String value) {
    // ref.read(sharedPreferencesProvider).setString(key, value);
  }

  //Function who get an exception value and return an error message in a toast
  void getException({Exception? exception, String message = ""}) {
    String errorMessage =
        message.isNotEmpty ? message : exception?.toString() ?? "";
    if (exception is FirebaseAuthException || exception is FirebaseException) {
      debugPrint("Error : ${exception.toString()}");
      Fluttertoast.showToast(
        msg: errorMessage,
        timeInSecForIosWeb: 5,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        webPosition: "center",
        fontSize: 16.0,
        webBgColor: "#ff3333",
        webShowClose: true,
      );
    } else if (exception is PlatformException) {
      debugPrint("Error : ${exception.code} ${exception.message}");
      Fluttertoast.showToast(
        msg: errorMessage,
        timeInSecForIosWeb: 5,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        webPosition: "center",
        fontSize: 16.0,
        webBgColor: "#ff3333",
        webShowClose: true,
      );
    } else if (errorMessage.isNotEmpty) {
      debugPrint("Error : $errorMessage");
      Fluttertoast.showToast(
        msg: errorMessage,
        timeInSecForIosWeb: 5,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        webPosition: "center",
        fontSize: 16.0,
        webBgColor: "#ff3333",
        webShowClose: true,
      );
    }
  }

  String createIdFromCompanyName(
    String companyName,
  ) {
    // Remove any whitespace from the company name
    String trimmedCompanyName = companyName.trim();

    // Convert the company name to lowercase
    String lowercaseCompanyName = trimmedCompanyName.toLowerCase();

    // Replace any spaces with hyphens
    String hyphenatedCompanyName = lowercaseCompanyName.replaceAll(' ', '-');

    // Generate a random key of 6 characters
    String randomKey = '';
    final random = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    for (var i = 0; i < 6; i++) {
      randomKey += chars[random.nextInt(chars.length)];
    }

    // Combine the hyphenated company name and the random key to form the ID
    String id = '$hyphenatedCompanyName-$randomKey';

    // Return the ID
    return id;
  }

  Future<bool> setCompanyDocument(
      {required String companyName, required MailSystem mailSystem}) async {
    try {
      // Create an ID based on the company name
      String id = createIdFromCompanyName(companyName);

      Map<String, dynamic> data = {
        "creationDate": DateTime.now(),
        "companyName": companyName,
        "companyCode": id,
        "owners": [currentUser!.uid],
        "mailSystem": mailSystem.toString(),
      };

      if (currentUser == null) {
        getException(message: "User is not logged in");
        return false;
      }

      // Check if a document with the same company name and user ID already exists
      bool documentExists = false;
      QuerySnapshot snapshot = await firestoreInstance
          .collection("companies")
          .where("companyName", isEqualTo: companyName)
          .where("owners", arrayContains: currentUser!.uid)
          .get();
      if (snapshot.docs.isNotEmpty) {
        documentExists = true;
      }

      // If a document with the same company name and user ID already exists, update the document
      if (documentExists) {
        String mailSystemInDoc = snapshot.docs[0]["mailSystem"];
        //Check if mail system is the same, if not, update it
        if (mailSystemInDoc != mailSystem.toString()) {
          await firestoreInstance
              .collection("companies")
              .doc(snapshot.docs[0].id)
              .update({"mailSystem": mailSystem.toString()});
        }

        return true;
      }

      // Add the ID to the data

      // Set the company document and the user document
      await firestoreInstance.collection("companies").doc(id).set(data);
      await firestoreInstance.collection("users").doc(currentUser!.uid).update({
        "companyName": companyName,
        "companyCode": id,
        "lastUpdate": DateTime.now(),
      });
      return true;
    } on Exception catch (e) {
      getException(exception: e);
      return false;
    }
  }

  Future<Company> initializeCompany() async {
    try {
      // Get the document link to the user in Firebase Firestore database

      if (currentUser == null) {
        return Company(
          id: "",
          creationDate: DateTime.now(),
          companyName: "",
          companyCode: "",
          owners: [],
        );
      }

      DocumentReference userDocument =
          firestoreInstance.collection("users").doc(currentUser!.uid);

      // Get the user document and convert it to a User object
      DocumentSnapshot userDocumentSnapshot = await userDocument.get();
      MasterUser user = MasterUser.fromDocumentSnapshot(userDocumentSnapshot);

      // Get the document link to the company in Firebase Firestore database
      QuerySnapshot companySnapshot = await firestoreInstance
          .collection("companies")
          .where("companyCode", isEqualTo: user.companyCode)
          .get();

      // Get the company document and convert it to a Company object
      DocumentSnapshot companyDocumentSnapshot = companySnapshot.docs.first;
      Company company = Company.fromDocumentSnapshot(companyDocumentSnapshot);

      //Get all the employees from Firebase Firestore database
      QuerySnapshot employeesSnapshot = await firestoreInstance
          .collection("companies")
          .doc(company.id)
          .collection("employees")
          .get();

      // Initialize the list of employees
      List<Employees> employees = [];

      // Convert the employee documents to Employees objects and add them to the list
      for (DocumentSnapshot employeeSnapshot in employeesSnapshot.docs) {
        Employees employee = Employees.fromDocumentSnapshot(employeeSnapshot);
        employees.add(employee);
      }
      company.employees = employees;

      return company;
    } on Exception catch (e) {
      getException(exception: e);
      return Company(
        id: "",
        creationDate: DateTime.now(),
        companyName: "",
        companyCode: "",
        owners: [],
      );
    }
  }
}

final authProvider = ChangeNotifierProvider<AuthBase>((ref) {
  return AuthBase(ref);
});

class CompanyNotifier extends StateNotifier<Company> {
  CompanyNotifier()
      : super(Company(
          id: "",
          creationDate: DateTime.now(),
          companyName: "",
          companyCode: "",
          owners: [],
        ));

  Future<void> loadCompany(String companyId) async {
    try {
      // Get the document link to the company in Firebase Firestore database
      DocumentSnapshot companyDocumentSnapshot =
          await firestoreInstance.collection("companies").doc(companyId).get();

      // Convert the company document to a Company object
      Company company = Company.fromDocumentSnapshot(companyDocumentSnapshot);

      // Get all the employees from Firebase Firestore database
      QuerySnapshot employeesSnapshot = await firestoreInstance
          .collection("companies")
          .doc(company.id)
          .collection("employees")
          .get();

      // Convert the employee documents to Employees objects and add them to the company object
      List<Employees> employees = employeesSnapshot.docs.map((doc) {
        return Employees.fromDocumentSnapshot(doc);
      }).toList();
      company.employees = employees;

      // Update the state of the CompanyNotifier
      state = company;
    } on Exception catch (e) {
      // Handle the exception
    }
  }

  // Future<void> updateCompany(Company company) async {
  //   try {
  //     await firestoreInstance
  //         .collection("companies")
  //         .doc(company.id)
  //         .update(company.toJson());
  //     state = company;
  //   } on Exception catch (e) {
  //     // Handle the exception
  //   }
  // }
}
