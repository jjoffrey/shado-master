import 'package:flutter/material.dart';
import 'package:shadowinner_master_settings/localization/string_hardcoded.dart';

import '../../widgets/text_column.dart';

class WorkTextColumn extends StatelessWidget {
  const WorkTextColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return TextColumn(
      title: 'Work together'.hardcoded,
      text:
          'Adipisicing anim ex excepteur duis quis in tempor eu ullamco adipisicing.'
              .hardcoded,
    );
  }
}
