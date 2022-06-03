import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:news_app/data/news_api_client.dart';
import 'package:news_app/data/news_respostory.dart';
import 'package:news_app/routes/routes.dart';
import 'package:news_app/viewmodel/favorite_tr.dart';
import 'package:news_app/viewmodel/favorite_us.dart';
import 'package:news_app/viewmodel/login.dart';
import 'package:news_app/viewmodel/register.dart';
import 'package:news_app/viewmodel/viewmodel.dart';
import 'package:news_app/widgets/home.dart';
import 'package:provider/provider.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton(() => NewsApiClient());
  getIt.registerLazySingleton(() => NewsRespoStory());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  setup();
  
  initializeDateFormatting('tr');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Firebase Hata Oluştu"),
            ),
          );
        }
        if (snapshot.hasData) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => NewsViewModel()),
              ChangeNotifierProvider(
                create: (context) => FavViewModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => FavTrViewModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => LoginProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => RegisterProvider(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Material App',
              theme: ThemeData(
                  appBarTheme: const AppBarTheme(
                      backgroundColor: Color.fromRGBO(244, 67, 54, 1)),
                  tabBarTheme: const TabBarTheme(labelColor: Colors.white)),
              onGenerateRoute: Routes.onGenerateRoute,
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
