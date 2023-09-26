import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadowinner_master_settings/screens/settings_master/components/radio_button.dart';
import 'package:shadowinner_master_settings/services/auth.dart';

import '../classes.dart';

class CompanyControllerNotifier extends AutoDisposeAsyncNotifier<Company> {
  @override
  FutureOr<Company> build() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(ref.read(authProvider).initializeCompany);

    return state.value!;
  }

  //Change the company name
  void changeCompanyName(String companyName) {
    if (!state.hasValue) return;
    state.value!.companyName = companyName;
  }

  void changeMailSystem(MailSystem? mailSystem) {
    if (!state.hasValue) return;
    state.value!.mailSystem = mailSystem;
  }
}

final companyControllerNotifierProvider =
    AsyncNotifierProvider.autoDispose<CompanyControllerNotifier, Company>(() {
  return CompanyControllerNotifier();
});



//TODO : trouver un moyen d'afficher les changements d'états car le provider ne se met pas à jour