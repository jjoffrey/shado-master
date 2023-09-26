import 'package:flutter/material.dart';
import 'package:shadowinner_master_settings/localization/string_hardcoded.dart';

import '../../widgets/text_column.dart';

class EducationTextColumn extends StatelessWidget {
  const EducationTextColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return TextColumn(
      title: 'Keep learning'.hardcoded,
      text: 'Ipsum magna enim cupidatat culpa elit cillum velit occaecat.'
          .hardcoded,
    );
  }
}
