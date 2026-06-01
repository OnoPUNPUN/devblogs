import 'package:devblogs/core/auth/auth_session.dart';
import 'package:devblogs/core/di/injection_container.dart';
import 'package:devblogs/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:devblogs/features/auth/presentation/pages/login_screen.dart';
import 'package:devblogs/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:devblogs/features/blog/domain/entities/blog.dart';
import 'package:devblogs/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:devblogs/features/blog/presentation/pages/add_new_blog_screen.dart';
import 'package:devblogs/features/blog/presentation/pages/blog_screen.dart';
import 'package:devblogs/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    refreshListenable: sl<AuthSession>(),
    redirect: (context, state) {
      final authSession = sl<AuthSession>();
      final location = state.matchedLocation;
      final isAuthRoute =
          location == LoginScreen.name || location == SingUpScreen.name;

      if (authSession.isAuthenticated && isAuthRoute) {
        return BlogScreen.name;
      }

      if (!authSession.isAuthenticated && !isAuthRoute) {
        return LoginScreen.name;
      }

      return null;
    },
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
        path: BlogScreen.name,
        name: BlogScreen.name,
        builder: (context, state) => const BlogScreen(),
      ),
      GoRoute(
        path: AddNewBlogScreen.name,
        name: AddNewBlogScreen.name,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<BlogBloc>(),
          child: const AddNewBlogScreen(),
        ),
      ),
      GoRoute(
        path: BlogViewerPage.name,
        name: BlogViewerPage.name,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<BlogBloc>(),
          child: BlogViewerPage(blog: state.extra! as Blog),
        ),
      ),
    ],
  );
}
