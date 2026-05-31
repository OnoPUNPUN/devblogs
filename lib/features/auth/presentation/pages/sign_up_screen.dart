import 'package:devblogs/features/auth/presentation/pages/login_screen.dart';
import 'package:devblogs/features/auth/presentation/widgets/auth_field.dart';
import 'package:devblogs/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:devblogs/features/auth/presentation/widgets/auth_notes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SingUpScreen extends StatefulWidget {
  static const name = "/sing-up-screen";
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final _fromKey = GlobalKey<FormState>();
  final _emailTEController = TextEditingController();
  final _nameTEController = TextEditingController();
  final _passwordTEController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _fromKey,
          child: Column(
            children: [
              const Text(
                "Sing Up",
                style: TextStyle(fontSize: 50, fontWeight: .bold),
              ),
              const Gap(50),
              AuthField(hintText: "Email", controller: _emailTEController),
              const Gap(16),
              AuthField(hintText: "Username", controller: _nameTEController),
              const Gap(16),
              AuthField(
                hintText: "Password",
                controller: _passwordTEController,
              ),
              const Gap(24),
              AuthGradientButton(
                text: "Sing Up",
                buttonColor: Colors.white,
                onPressed: () {},
              ),
              const Gap(16),
              AuthNotes(
                normalText: "Already Have an Account?",
                text: " Sing In",
                onPressed: () {
                  context.push(LoginScreen.name);
                },
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
    _nameTEController.dispose();
    _passwordTEController.dispose();
  }
}
