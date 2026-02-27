import 'package:firebase_auth/firebase_auth.dart';

class AdminService {
  static bool isAdmin() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return false;

    // Change to your admin email
    return user.email == "admin@gmail.com";
  }
}
