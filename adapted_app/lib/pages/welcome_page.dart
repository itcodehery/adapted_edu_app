import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(children: [
            Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/splash.jpg'),
                        fit: BoxFit.cover)),
                height: MediaQuery.of(context).size.height * 0.4),
            Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.white,
                      Colors.white60,
                      Color.fromARGB(0, 255, 255, 255),
                    ])),
                height: 70),
          ]),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("adapted.", style: TextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                // const Divider(),
                const Text('Create personalized',
                    style: TextStyle(fontSize: 42)),
                Text('engaging lesson plans effortlessly.',
                    style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w600,
                        color: Colors.amber.shade800)),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                    backgroundColor:
                        WidgetStatePropertyAll(Colors.amber.shade800),
                    minimumSize: const WidgetStatePropertyAll(
                        Size(double.infinity, 70))),
                onPressed: () {
                  // Navigator.of(context).pushNamed('/auth');
                  GoRouter.of(context).go('/auth');
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Get Started',
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward_rounded, color: Colors.black),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
