# Dev Blogs

Dev Blogs is a Flutter mobile application for reading and publishing developer-focused blog posts. It includes authentication, protected routing, a blog feed, category/topic selection, image upload, and detailed article reading backed by a REST API.

Backend repository: [OnoPUNPUN/Dev-Blog-Backend](https://github.com/OnoPUNPUN/Dev-Blog-Backend.git)

## Features

- User registration and login with JWT-based authentication.
- Session persistence with `shared_preferences` and automatic 24-hour expiry.
- Protected navigation using `go_router`.
- Blog feed with pull-to-refresh.
- Blog details page with author, date, reading time, image, and full content.
- Create new blog posts with title, content, one or more categories, and an optional image.
- Multipart image upload support through Dio.
- Clean feature-based structure with separate data, domain, and presentation layers.
- Dependency injection through `get_it`.
- State management with `flutter_bloc`.
- Connectivity-aware repository layer.

## Tech Stack

- Flutter 3.44.0
- Dart SDK 3.11.4 or newer
- BLoC for state management
- GoRouter for navigation
- Dio for HTTP networking
- GetIt for dependency injection
- Fpdart for functional error handling
- Shared Preferences for local session storage
- Image Picker for selecting blog images

## Backend

The mobile app currently points to the deployed API:

```text
https://dev-blog-backend-production-7195.up.railway.app
```

The base URL is configured in:

```text
lib/core/network/dio_provider.dart
```

To run against your own backend, clone and start the backend project from:

```text
https://github.com/OnoPUNPUN/Dev-Blog-Backend.git
```

Then update the `baseUrl` in `DioProvider.createDio()`.

## API Usage

The Flutter app expects these backend routes:

| Method | Endpoint | Purpose |
| --- | --- | --- |
| `POST` | `/auth/register` | Register a new user |
| `POST` | `/auth/login` | Login and receive an auth token |
| `GET` | `/categories` | Fetch blog categories |
| `GET` | `/blogs` | Fetch all blogs |
| `POST` | `/blogs` | Create a blog post |
| `GET` | `/blogs/:id` | Fetch a single blog post |

Authenticated requests send the token as:

```text
Authorization: Bearer <token>
```

## Project Structure

```text
lib/
  core/
    auth/              Session persistence and token handling
    common/            Shared widgets
    di/                Service locator setup
    error/             Exceptions and failures
    network/           Dio provider, API client, network checks
    routing/           GoRouter configuration
    theme/             App colors and theme
    utils/             Helpers for logging, dates, reading time, image picking
  features/
    auth/
      data/            Remote data source, models, repository implementation
      domain/          Entities, repository contract, use cases
      presentation/    BLoC, login screen, sign-up screen, auth widgets
    blog/
      data/            Remote data source, models, repository implementation
      domain/          Entities, repository contract, use cases
      presentation/    BLoC, feed, editor, details page, blog widgets
```

## Getting Started

### Prerequisites

- Flutter SDK 3.44.0 or compatible
- Dart SDK 3.11.4 or compatible
- Android Studio, Xcode, or VS Code with Flutter tooling
- A running Android emulator, iOS simulator, or physical device
- Optional: FVM, because this project includes `.fvmrc`

### Install Dependencies

Using Flutter directly:

```bash
flutter pub get
```

Using FVM:

```bash
fvm flutter pub get
```

### Run the App

```bash
flutter run
```

Or with FVM:

```bash
fvm flutter run
```

### Analyze the Project

```bash
flutter analyze
```

### Run Tests

```bash
flutter test
```

## Platform Notes

Android permissions are configured for:

- Internet access
- Image selection on Android 13+
- External storage image access on Android 12 and lower

The app currently includes Android and iOS project files.

## Main App Flow

1. The app initializes dependencies in `lib/core/di/injection_container.dart`.
2. `AuthSession` restores a saved token from local storage.
3. `GoRouter` redirects unauthenticated users to the login screen.
4. Authenticated users are routed to the blog feed.
5. Users can open blog details or create a new blog post.
6. New posts can include selected categories and an optional image.

## Important Files

- `lib/main.dart` - App entry point and root widget.
- `lib/core/routing/app_router.dart` - Route definitions and auth redirects.
- `lib/core/network/dio_provider.dart` - API base URL and Dio configuration.
- `lib/core/network/api_client.dart` - Shared HTTP client with auth header support.
- `lib/core/auth/auth_session.dart` - Token persistence and expiry logic.
- `lib/features/auth/presentation/bloc/auth_bloc.dart` - Authentication state management.
- `lib/features/blog/presentation/bloc/blog_bloc.dart` - Blog and category state management.

## License

No license file is currently included. Add one before distributing or publishing the project.
