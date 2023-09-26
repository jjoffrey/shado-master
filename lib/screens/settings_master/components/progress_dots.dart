import 'package:flutter/material.dart';
import 'package:shadowinner_master_settings/constants.dart';

class OnboardingWidget extends StatefulWidget {
  //create two functions to handle next and back button with a bool return type
  final Future<bool> Function() onNextPressed;
  final bool Function() onBackPressed;
  final int noOfScreen;

  const OnboardingWidget(
      {super.key,
      required this.onNextPressed,
      required this.onBackPressed,
      required this.noOfScreen});
  @override
  _OnboardingWidgetState createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  //create two callback functions to handle next and back button

  int currentScreenNo = 0;

  _OnboardingWidgetState(); // Change this to the number of screens you have

  void onNextPressed() async {
    if (await widget.onNextPressed()) {
      setState(() {
        currentScreenNo++;
      });
    }

    // Call your function here
  }

  void onBackPressed() {
    if (widget.onBackPressed()) {
      setState(() {
        currentScreenNo--;
      });
    }
    // Call your function here
  }

  @override
  Widget build(BuildContext context) {
    bool isFirstScreen = currentScreenNo == 0;
    bool isLastScreen = currentScreenNo == widget.noOfScreen - 1;

    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      color: kDarkBlue,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ... your other widgets ...

          Visibility(
            visible: !isLastScreen,
            replacement: Row(
              mainAxisAlignment: widget.noOfScreen > 0
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: [
                if (widget.noOfScreen > 0)
                  RoundedButton(
                    title: "Back",
                    onPressed: () {
                      onBackPressed();
                    },
                  ),
                Row(
                  children: [
                    for (int index = 0; index < widget.noOfScreen; index++)
                      createProgressDots(index == currentScreenNo)
                  ],
                ),
                SizedBox(
                    width: 100,
                    height: 30,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        onPressed: () {},
                        child: Text('Submit',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    color: kWhite,
                                    fontWeight: FontWeight.bold)))),
                //create same button but with a yellow color
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!isFirstScreen)
                  RoundedButton(
                    title: "Back",
                    onPressed: () {
                      onBackPressed();
                    },
                  ),
                //put a sized box with the same size as elevevated button here to give space between back and next button

                if (isFirstScreen) const SizedBox(width: 100),
                Row(
                  children: [
                    for (int index = 0; index < widget.noOfScreen; index++)
                      createProgressDots(index == currentScreenNo)
                  ],
                ),
                RoundedButton(
                  title: "Next",
                  onPressed: () {
                    if (isLastScreen) {
                      // Handle finish action
                    } else {
                      onNextPressed();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Create a function to create progress dots
  Widget createProgressDots(bool isActiveScreen) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: isActiveScreen ? 15 : 10,
      width: isActiveScreen ? 15 : 10,
      decoration: BoxDecoration(
        color: isActiveScreen ? kPrimary : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const RoundedButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: kWhite, fontWeight: FontWeight.normal)),
      ),
    );
  }
}
