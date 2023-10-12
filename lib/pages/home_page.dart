import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spm/core/app_export.dart';
import 'package:spm/pages/Admin/admin.dart';
import 'package:spm/pages/check_eye.dart';
import 'package:spm/pages/game_list.dart';
import 'package:spm/pages/user_gamelist.dart';
import 'package:spm/pages/vfd_test_card.dart';
import 'package:spm/pages/vision/vision.dart';
import 'package:spm/pages/visual_fatigue_homePage.dart';
import 'package:spm/pages/Eye_reports/blind_report.dart';
import 'package:spm/pages/Eye_reports/vsion_report.dart';
import 'blindness/blindness.dart';
import 'profile_page.dart';
import 'questionaire/questionaire_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void goToProfilePage(BuildContext context) {
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  void goToQuizPage(BuildContext context) {
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const QuestionnaireScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 28, 122, 47),
          title: const Text('H O M E  P A G E'),
        ),
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 149, 156, 162),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 120,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 28, 122, 47),
                ),
                child: const Center(
                  child: Text(
                    'M E N U',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ListTile(
                title: const Text('P R O F I L E',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  goToProfilePage(context);
                },
              ),
              ListTile(
                title: const Text('V I S U A L   F A T I G U E   T E S T',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VisualFatigueTestPage(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('E Y E  G A M E S',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  if (user.email == "admin@gmail.com") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameList(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserGameList(),
                      ),
                    );
                  } // Add your logic for Eye Games here
                },
              ),
              ListTile(
                title: const Text('Q U I Z',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  goToQuizPage(context);
                },
              ),
              ListTile(
                title: const Text('C H E C K  Y O U R  E Y E ',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const CheckEye()));
                },
              ),
              ListTile(
                title: const Text('C R E A T E  T E S T',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const Admin()));
                },
              ),
              const SizedBox(height: 180),
              ListTile(
                title: const Text('L O G O U T',
                    style: TextStyle(color: Colors.white)),
                onTap: signUserOut,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.green[100],
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: _buildOfferScreen(context),
            ),
            GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16.0),
              physics: NeverScrollableScrollPhysics(), // this line is important
              shrinkWrap: true, // this line is important
              children: <Widget>[
                _buildCard(
                    title: 'Eye Games',
                    image: 'lib/images/game.png',
                    onTap: () {
                      if (user.email == "admin@gmail.com") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GameList(),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserGameList(),
                          ),
                        );
                      }
                    }),
                _buildCard(
                  title: 'Quiz',
                  image: 'lib/images/quiz.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuestionnaireScreen(),
                      ),
                    );
                  },
                ),
                _buildCard(
                  title: 'Color Blindness',
                  image: 'lib/images/blind.jpg',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Blindness(),
                      ),
                    );
                  },
                ),
                _buildCard(
                  title: 'Contrast Sensitivity',
                  image: 'lib/images/eye_logoblid.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Vision(),
                      ),
                    );
                  },
                ),
              ],
            )
          ]),
        ));
  }

  Widget _buildCard(
      {required String title,
      required String image,
      required Function() onTap}) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              image,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Section Widget
  Widget _buildOfferScreen(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(height: 16.v);
        },
        itemCount: 1,
        itemBuilder: (context, index) {
          return const OfferscreenItemWidget();
        });
  }
}
