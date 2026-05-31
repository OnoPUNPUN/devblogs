import 'package:devblogs/features/auth/presentation/pages/login_screen.dart';
import 'package:devblogs/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: LoginScreen.name,
        name: LoginScreen.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: SingUpScreen.name,
        name: SingUpScreen.name,
        builder: (context, state) => const SingUpScreen(),
      ),
    ],
  );
}
