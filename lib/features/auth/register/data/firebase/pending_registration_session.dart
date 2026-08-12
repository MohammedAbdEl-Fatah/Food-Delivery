class PendingRegistrationSession {
  PendingRegistrationSession._();

  static String? userId;
  static String? email;
  static String? password;

  static void save({
    required String userId,
    required String email,
    required String password,
  }) {
    PendingRegistrationSession.userId = userId;
    PendingRegistrationSession.email = email;
    PendingRegistrationSession.password = password;
  }

  static void clear() {
    userId = null;
    email = null;
    password = null;
  }

  static bool get hasSession =>
      userId != null && email != null && password != null;
}
