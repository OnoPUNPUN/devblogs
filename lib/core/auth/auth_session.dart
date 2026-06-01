import 'dart:async';

import 'package:devblogs/core/network/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthSession extends ChangeNotifier {
  static const _tokenKey = 'auth_token';
  static const _createdAtKey = 'auth_token_created_at';
  static const sessionDuration = Duration(hours: 24);

  final SharedPreferences _preferences;
  final ApiClient _apiClient;

  String? _token;
  DateTime? _createdAt;
  Timer? _expiryTimer;

  AuthSession({
    required SharedPreferences preferences,
    required ApiClient apiClient,
  }) : _preferences = preferences,
       _apiClient = apiClient;

  bool get isAuthenticated {
    if (_token == null || _createdAt == null) return false;
    return DateTime.now().isBefore(_createdAt!.add(sessionDuration));
  }

  Future<void> restoreSession() async {
    _token = _preferences.getString(_tokenKey);
    final createdAtValue = _preferences.getString(_createdAtKey);
    _createdAt = createdAtValue == null
        ? null
        : DateTime.tryParse(createdAtValue);

    if (!isAuthenticated) {
      await clearSession(notify: false);
      return;
    }

    _apiClient.updateToken(_token);
    _scheduleExpiry();
  }

  Future<void> saveToken(String token) async {
    _token = token;
    _createdAt = DateTime.now();

    await _preferences.setString(_tokenKey, token);
    await _preferences.setString(_createdAtKey, _createdAt!.toIso8601String());

    _apiClient.updateToken(token);
    _scheduleExpiry();
    notifyListeners();
  }

  Future<void> clearSession({bool notify = true}) async {
    _expiryTimer?.cancel();
    _expiryTimer = null;
    _token = null;
    _createdAt = null;

    await _preferences.remove(_tokenKey);
    await _preferences.remove(_createdAtKey);

    _apiClient.updateToken(null);
    if (notify) notifyListeners();
  }

  void _scheduleExpiry() {
    _expiryTimer?.cancel();

    if (_createdAt == null) return;

    final expiresAt = _createdAt!.add(sessionDuration);
    final remaining = expiresAt.difference(DateTime.now());

    if (remaining <= Duration.zero) {
      unawaited(clearSession());
      return;
    }

    _expiryTimer = Timer(remaining, clearSession);
  }

  @override
  void dispose() {
    _expiryTimer?.cancel();
    super.dispose();
  }
}
