import 'package:adapted_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelper {
  static Future<void> signInWithGoogle() async {}

  static Future<void> signInWithEmail(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(password: password, email: email);
    } on PostgrestException catch (e) {
      debugPrint(e.message);
    }
  }

  static Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } on PostgrestException catch (e) {
      debugPrint(e.message);
    }
  }
}
