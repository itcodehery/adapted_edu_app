import 'package:adapted_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends Notifier<Future<bool>> {
  @override
  Future<bool> build() async {
    await Future.delayed(Duration.zero);
    debugPrint("inside redirect!");
    final session = supabase.auth.currentSession;
    return session != null;
  }
}

final authNotifierProvider = NotifierProvider<AuthNotifier, Future<bool>>(() {
  return AuthNotifier();
});
