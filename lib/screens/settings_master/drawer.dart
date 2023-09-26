import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadowinner_master_settings/classes.dart';
import 'package:shadowinner_master_settings/common/async_value_widget.dart';
import 'package:shadowinner_master_settings/provider/company_provider.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: AsyncValueWidget(
                value: ref.watch(companyControllerNotifierProvider),
                data: (company) =>
                    Text('Connected to company: ${company.companyName}')),
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              // Navigate to the settings page or perform your desired action.
              Navigator.pop(context); // Close the drawer.
            },
          ),
        ],
      ),
    );
  }
}
