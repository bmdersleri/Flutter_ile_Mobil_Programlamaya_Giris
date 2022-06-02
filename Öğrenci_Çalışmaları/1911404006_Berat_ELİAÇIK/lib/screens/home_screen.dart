import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projemmmm/screens/quiz_category.dart';
import 'package:projemmmm/screens/quiz_history_screen.dart';
import 'package:projemmmm/screens/quiz_screen.dart';
import 'package:projemmmm/screens/traffic_signs.dart';

import '../common/alert_util.dart';
import '../common/theme_helper.dart';
import '../stores/quiz_store.dart';

import '../widgets/disco_button.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final QuizStore _quizStore = QuizStore();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: navigationDrawer(),
        body: Container(
          alignment: Alignment.center,
          decoration: ThemeHelper.fullScreenBgBoxDecoration(),
          child: Column(
            children: [
              drawerToggleButton(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: ClipOval(
                      child: Container(
                        width: 130,
                        height: 130,
                        color: ThemeHelper.primaryColor,
                        alignment: Alignment.center,
                        child: Icon(Icons.traffic_outlined,
                            color: Colors.white, size: 100),
                      ),
                    ),
                  ),

                  SizedBox(height: 90),

                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                    child: FlatButton(
                      onPressed: () async {
                        var quiz = await _quizStore.getRandomQuizAsync();
                        Navigator.pushNamed(context, QuizScreen.routeName,
                            arguments: quiz);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              50) //Sınava Başla butonunun kenarlarını yumuşak geçişli yaptık.
                          ),
                      color: ThemeHelper.primaryColor,
                      padding: EdgeInsets.all(25),
                      child: Text(
                        "Sınava Başla",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                      bottom: 20,
                    ),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, QuizCategoryScreen.routeName);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              50) //Sınav Konuları butonunun kenarlarını yumuşak geçişli yaptık.
                          ),
                      color: ThemeHelper.primaryColor,
                      padding: EdgeInsets.all(25),
                      child: Text(
                        "Sınav Konuları",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, QuizHistoryScreen.routeName);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              50) //hemen giriş yap butonunun kenarlarını yumuşak geçişli yaptık.
                          ),
                      color: ThemeHelper.primaryColor,
                      padding: EdgeInsets.all(25),
                      child: Text(
                        "Çözdüğüm Denemeler",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Drawer navigationDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [

                Text(
                  "Ehliyet Sınavı",
                  style: TextStyle(color: Colors.white, fontSize: 32),
                ),

                Text(
                  "Version: 1.0.2",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Anasayfa'),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            },
          ),
          ListTile(
            title: const Text('Sınava Başla'),
            leading: Icon(Icons.access_alarm),
            onTap: () async {
              var quiz = await _quizStore.getRandomQuizAsync();
              Navigator.pushNamed(context, "/quiz", arguments: quiz);
            },
          ),
          ListTile(
            title: const Text('Sınav Konuları'),
            leading: Icon(Icons.book),
            onTap: () {
              Navigator.pushNamed(context, QuizCategoryScreen.routeName);
            },
          ),
          ListTile(
            title: const Text('Çözdüğüm Denemeler'),
            leading: Icon(Icons.quiz),
            onTap: () {
              Navigator.pushNamed(context, QuizHistoryScreen.routeName);
            },

          ),
          ListTile(
            title: const Text('Trafik İşaretleri'),
            leading: Icon(Icons.traffic),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TrafficSigns()
                  )
              );
            },

          ),
          Divider(
            thickness: 2,
          ),
          ListTile(
            title: const Text('Hakkında'),
            leading: Icon(Icons.info),
            onTap: () {
              AlertUtil.showAlert(context, "Hakkında",
                  "Berat Eliaçık \nberateliacikk@gmail.com");
            },
          ),
          ListTile(
            title: const Text('Çıkış'),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget drawerToggleButton() {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 20),
      alignment: Alignment.topLeft,
      child: GestureDetector(
        child: Image(
          image: AssetImage("assets/icons/menu.png"),
          width: 36,
        ),
        onTap: () {
          _key.currentState!.openDrawer();
        },
      ),
    );
  }


}
