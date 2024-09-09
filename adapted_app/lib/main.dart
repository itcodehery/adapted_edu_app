import 'package:adapted_app/pages/auth_page.dart';
import 'package:adapted_app/pages/home_page.dart';
import 'package:adapted_app/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Supabase.initialize(
      url: dotenv.env['PROJ_URL']!, anonKey: dotenv.env['PROJ_KEY']!);
  runApp(const Adapted());
}

class Adapted extends StatelessWidget {
  const Adapted({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.dmSansTextTheme(),
        primaryColor: Colors.amber.shade800,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const WelcomePage(),
        '/welcome': (context) => const WelcomePage(),
        '/auth': (context) => const AuthPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
