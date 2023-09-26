import 'package:flutter/material.dart';
import 'package:shadowinner_master_settings/localization/string_hardcoded.dart';

import '../../../constants.dart';
import '../../login/widgets/logo.dart';

class Header extends StatelessWidget {
  final VoidCallback onSkip;

  const Header({
    super.key,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Logo(
          color: kWhite,
          size: 32.0,
        ),
        GestureDetector(
          onTap: onSkip,
          child: Text(
            'Skip'.hardcoded,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: kWhite,
                ),
          ),
        ),
      ],
    );
  }
}
