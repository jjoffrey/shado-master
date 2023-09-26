import 'package:flutter/material.dart';
import 'package:shadowinner_master_settings/localization/string_hardcoded.dart';

import '../../widgets/text_column.dart';

class CommunityTextColumn extends StatelessWidget {
  const CommunityTextColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return TextColumn(
      title: 'Community'.hardcoded,
      text:
          'Eu sint do id aliqua qui tempor sint cillum commodo id voluptate qui.'
              .hardcoded,
    );
  }
}
