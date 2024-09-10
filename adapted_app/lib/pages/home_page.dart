import 'package:adapted_app/helper/supabase_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = {
      'Create Lesson': () {},
      'Explore Templates': () {},
      'Recent Lessons': () {},
      'Settings': () {}
    };
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const CircleAvatar(
            backgroundImage: AssetImage('assets/splash.jpg'),
          ),
        ),
        title: const Text('adapted.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: const [
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: SupabaseHelper.signOut,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
              shrinkWrap: true,
              itemCount: actions.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 4),
              itemBuilder: (context, index) {
                return ElevatedButton(
                  style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      foregroundColor: const WidgetStatePropertyAll(
                        Colors.black87,
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).primaryColor.withOpacity(0.2),
                      ),
                      elevation: const WidgetStatePropertyAll(0)),
                  onPressed: () {},
                  child: Text(actions.keys.elementAt(index),
                      style: const TextStyle(fontSize: 16)),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text('Recent Activities', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Card(
              color: Colors.blue.shade200.withOpacity(0.4),
              elevation: 0,
              child: SizedBox(
                height: 300,
                child: Column(
                  children: [
                    const ListTile(
                      leading: FaIcon(FontAwesomeIcons.penNib),
                      title: Text('Data Analytics',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Computer Applications Class - Sem 5'),
                      trailing: Icon(Icons.more_vert),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            minimumSize: const WidgetStatePropertyAll(
                              Size(double.infinity, 60),
                            ),
                            foregroundColor:
                                const WidgetStatePropertyAll(Colors.black),
                            backgroundColor: const WidgetStatePropertyAll(
                              Colors.white,
                            ),
                          ),
                          onPressed: () {},
                          child: const Text('12 Chapters - 28hr 30min',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
