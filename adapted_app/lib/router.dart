import 'package:adapted_app/pages/auth_page.dart';
import 'package:adapted_app/pages/home_page.dart';
import 'package:adapted_app/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/welcome',
  redirect: (context, state) {
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(path: '/auth', builder: (context, state) => const AuthPage()),
  ],
);
