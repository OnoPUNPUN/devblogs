import 'package:devblogs/features/auth/presentation/widgets/auth_field.dart';
import 'package:devblogs/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  static const name = "/login-screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _fromKey = GlobalKey<FormState>();
  final _emailTEController = TextEditingController();
  final _passwordTEController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _fromKey,
          child: Column(
            mainAxisAlignment: .center,
            children: [
              const Text(
                "Sing In",
                style: TextStyle(fontSize: 50, fontWeight: .bold),
              ),
              const Gap(30),
              AuthField(hintText: "Email", controller: _emailTEController),
              const Gap(16),
              AuthField(
                hintText: "Password",
                controller: _passwordTEController,
              ),
              const Gap(24),
              AuthGradientButton(
                text: "Sing In",
                buttonColor: Colors.white,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
  }
}
