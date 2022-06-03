import 'package:flutter/material.dart';

import 'package:projemmmm/stores/quiz_store.dart';

import 'common/route_generator.dart';
import 'common/theme_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await QuizStore.initPrefs();
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quiz App',
      theme: ThemeHelper.getThemeData(),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
/*void main() {
  runApp(MaterialApp(
      theme: ThemeData(fontFamily: 'Raleway'), // uygulama fontunu ekledik
      debugShowCheckedModeBanner: false, //sag ustteki debug yazısını kaldırdık
      home:SplashScreen(

      ) //SplashPage(duration: 3, goToPage: WelcomePage()) // acilis ekrani bekleme suresi ve gidecek olan sayfa ayarlandi.
  ));
}*/
