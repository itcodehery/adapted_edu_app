import 'dart:async';

import 'package:adapted_app/constants.dart';
import 'package:adapted_app/helper/supabase_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  // variables
  late final StreamSubscription<AuthState> _auth;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  bool isLoading = false;
  AuthType authType = AuthType.isLogin;
  late TabController tabController;
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _signupKey = GlobalKey<FormState>();

  // build methods
  @override
  void initState() {
    super.initState();
    // initialize the tab controller
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {
        authType =
            tabController.index == 0 ? AuthType.isLogin : AuthType.isRegister;
      });
      debugPrint(tabController.index.toString());
    });
    // listen to auth changes
    _auth = supabase.auth.onAuthStateChange.listen((event) {
      final session = event.session;
      if (session != null && mounted) {
        context.goNamed('home');
      }
    });
  }

  // variables
  final ButtonStyle _loginWithButton = ButtonStyle(
    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Colors.grey.shade100,
          width: 1,
        ))),
    backgroundColor: const WidgetStatePropertyAll(Colors.white),
    elevation: const WidgetStatePropertyAll(0),
    minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 50)),
  );

  //main build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('adapt',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            Text('ed',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber.shade900)),
            const Text('.',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(14.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Welcome to adapted.", style: TextStyle(fontSize: 24)),
                    Text(
                        "Sign up or log in to start managing your lesson plans ."),
                  ],
                ),
              ),
              TabBar(
                labelColor: Colors.amber.shade900,
                overlayColor: WidgetStatePropertyAll(Colors.amber.shade100),
                indicatorColor: Colors.amber.shade900,
                tabs: const [
                  Tab(text: 'Login', icon: Icon(Icons.login)),
                  Tab(text: 'Sign Up', icon: Icon(Icons.person_add_alt)),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // Login Tab
                    SingleChildScrollView(
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          padding: const EdgeInsets.all(14.0),
                          child: Form(
                            key: _loginKey,
                            child: Column(
                              children: [
                                ElevatedButton(
                                    style: _loginWithButton,
                                    onPressed: () {},
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(FontAwesomeIcons.apple,
                                            color: Colors.black),
                                        SizedBox(width: 10),
                                        Text('Login with Apple',
                                            style:
                                                TextStyle(color: Colors.black)),
                                      ],
                                    )),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                    style: _loginWithButton,
                                    onPressed: () {},
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(FontAwesomeIcons.google,
                                            color: Colors.black),
                                        SizedBox(width: 10),
                                        Text('Login with Google',
                                            style:
                                                TextStyle(color: Colors.black)),
                                      ],
                                    )),
                                const SizedBox(height: 20),
                                const Text('or continue with email'),
                                const SizedBox(height: 20),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field is necessary';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: 'Email',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)))),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field is necessary';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: 'Password',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)))),
                                ),
                                const SizedBox(height: 10),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text("Forgot Password?",
                                      style: TextStyle(color: Colors.grey)),
                                ),
                                const Spacer(),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        shape: WidgetStatePropertyAll(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                        backgroundColor: WidgetStatePropertyAll(
                                            Colors.amber.shade800),
                                        minimumSize:
                                            const WidgetStatePropertyAll(
                                                Size(double.infinity, 50))),
                                    onPressed: isLoading
                                        ? null
                                        : () {
                                            if (_loginKey.currentState!
                                                .validate()) {
                                              SupabaseHelper.signInWithEmail(
                                                  emailController.text,
                                                  passwordController.text);
                                            }
                                          },
                                    child: isLoading
                                        ? const CircularProgressIndicator()
                                        : const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text('Login',
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              SizedBox(width: 10),
                                              Icon(Icons.arrow_forward_rounded,
                                                  color: Colors.black),
                                            ],
                                          )),
                                const SizedBox(height: 20),
                                const Text(
                                  'By signing in, you are agreeing to our Terms of Service and Privacy Policy',
                                  style: TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )),
                    ),
                    // Sign Up Tab
                    SizedBox(
                        child: SingleChildScrollView(
                            child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Form(
                            key: _signupKey,
                            child: Column(children: [
                              ElevatedButton(
                                  style: _loginWithButton,
                                  onPressed: () {},
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(FontAwesomeIcons.apple,
                                          color: Colors.black),
                                      SizedBox(width: 10),
                                      Text('Sign Up with Apple',
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ],
                                  )),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                  style: _loginWithButton,
                                  onPressed: () {},
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(FontAwesomeIcons.google,
                                          color: Colors.black),
                                      SizedBox(width: 10),
                                      Text('Sign Up with Google',
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ],
                                  )),
                              const SizedBox(height: 20),
                              const Text('or continue with email'),
                              const SizedBox(height: 20),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This field is necessary';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    hintText: 'Email',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This field is necessary';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    hintText: 'Password',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This field is necessary';
                                  }
                                  if (value != passwordController.text) {
                                    return "Passwords don't match!";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    hintText: 'Confirm Password',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                              ),
                              const Spacer(),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      shape: WidgetStatePropertyAll(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                      backgroundColor: WidgetStatePropertyAll(
                                          Colors.amber.shade800),
                                      minimumSize: const WidgetStatePropertyAll(
                                          Size(double.infinity, 50))),
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                          if (_signupKey.currentState!
                                              .validate()) {
                                            SupabaseHelper.signInWithEmail(
                                                emailController.text.trim(),
                                                passwordController.text.trim());
                                            setState(() {
                                              isLoading = true;
                                            });
                                          }
                                        },
                                  child: isLoading
                                      ? const CircularProgressIndicator()
                                      : const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('Sign Up',
                                                style: TextStyle(
                                                    color: Colors.black)),
                                            SizedBox(width: 10),
                                            Icon(Icons.arrow_forward_rounded,
                                                color: Colors.black),
                                          ],
                                        )),
                              const SizedBox(height: 20),
                              const Text(
                                'By signing up, you are agreeing to our Terms of Service and Privacy Policy',
                                style: TextStyle(color: Colors.grey),
                                textAlign: TextAlign.center,
                              )
                            ]),
                          )),
                    )))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
