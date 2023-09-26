import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadowinner_master_settings/services/auth.dart';

import '../../../constants.dart';
import 'custom_button.dart';
import 'custom_input_field.dart';
import 'fade_slide_transition.dart';

class LoginForm extends ConsumerStatefulWidget {
  final Animation<double> animation;
  const LoginForm({required this.animation, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? kSpaceM : kSpaceS;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
      child: Form(
        key: GlobalKey<FormState>(),
        child: Column(
          children: <Widget>[
            FadeSlideTransition(
              animation: widget.animation,
              additionalOffset: 0.0,
              child: CustomInputField(
                autofillHints: const [AutofillHints.email],
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                label: 'Email',
                prefixIcon: Icons.person,
                obscureText: false,
              ),
            ),
            SizedBox(height: space),
            FadeSlideTransition(
              animation: widget.animation,
              additionalOffset: space,
              child: CustomInputField(
                autofillHints: const [AutofillHints.password],
                keyboardType: TextInputType.text,
                controller: _passwordController,
                label: 'Password',
                prefixIcon: Icons.lock,
                obscureText: true,
              ),
            ),
            SizedBox(height: space),
            FadeSlideTransition(
              animation: widget.animation,
              additionalOffset: 2 * space,
              child: CustomButton(
                color: kPrimary,
                textColor: kWhite,
                text: 'Sign In',
                onPressed: () async {
                  ref.read(authProvider).signInWithEmailAndPassword(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );
                },
              ),
            ),
            const SizedBox(height: 20),
            FadeSlideTransition(
              animation: widget.animation,
              additionalOffset: 2 * space,
              child: CustomButton(
                color: kWhite,
                textColor: kPrimary,
                text: 'Create an account',
                onPressed: () async {
                  ref.read(authProvider).createAnAccount(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
