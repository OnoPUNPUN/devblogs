import 'package:devblogs/core/di/injection_container.dart';
import 'package:devblogs/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:devblogs/features/auth/presentation/pages/login_screen.dart';
import 'package:devblogs/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:devblogs/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: LoginScreen.name,
        name: LoginScreen.name,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<AuthBloc>(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: SingUpScreen.name,
        name: SingUpScreen.name,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<AuthBloc>(),
          child: const SingUpScreen(),
        ),
      ),
      GoRoute(
        path: BlogPage.name,
        name: BlogPage.name,
        builder: (context, state) => const BlogPage(),
      ),
    ],
  );
}
