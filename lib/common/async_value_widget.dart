import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadowinner_master_settings/constants.dart';
import 'package:shadowinner_master_settings/routing/not_found_screen.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget(
      {super.key,
      required this.value,
      required this.data,
      this.isLoadingVisible = true,
      this.isLottie = false});
  final AsyncValue<T> value;
  final Widget Function(T) data;
  final bool isLoadingVisible;
  final bool isLottie;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (e, st) => Center(
          child: NotFoundScreen(
        errorMessage: e.toString(),
      )),
      loading: () => isLoadingVisible
          ? (isLottie
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 8, left: 8.0, right: 8.0),
                    child: CircularProgressIndicator(color: kPrimary),
                  ),
                )
              : const Center(child: CircularProgressIndicator(color: kPrimary)))
          : const SizedBox.shrink(),
    );
  }
}
