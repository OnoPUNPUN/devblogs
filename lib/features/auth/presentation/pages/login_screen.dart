import 'package:devblogs/core/common/widgets/loader.dart';
import 'package:devblogs/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:devblogs/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:devblogs/features/auth/presentation/widgets/auth_field.dart';
import 'package:devblogs/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:devblogs/features/auth/presentation/widgets/auth_notes.dart';
import 'package:devblogs/features/blog/presentation/pages/blog_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  static const name = "/";
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
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }

            if (state is AuthSuccess) {
              context.go(BlogScreen.name);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return Form(
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
                    onPressed: () {
                      if (_fromKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthLoginRequested(
                            email: _emailTEController.text.trim(),
                            password: _passwordTEController.text.trim(),
                          ),
                        );
                      }
                    },
                  ),
                  const Gap(16),
                  AuthNotes(
                    normalText: "Don't Have an account?",
                    text: " Sing Up",
                    onPressed: () {
                      context.push(SingUpScreen.name);
                    },
                  ),
                ],
              ),
            );
          },
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
