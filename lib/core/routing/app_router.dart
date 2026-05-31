import 'package:devblogs/features/auth/presentation/pages/login_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: LoginScreen.name,
        builder: (context, state) => const LoginScreen(),
      ),
    ],
  );
}
