import 'package:flutter/material.dart';
import 'package:flutter_app/api/firebase.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/login.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseApi.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: const MaterialColor(
            0xFF37474F,
            <int, Color>{
              50: Color(0xFFECEFF1),
              100: Color(0xFFCFD8DC),
              200: Color(0xFFB0BEC5),
              300: Color(0xFF90A4AE),
              400: Color(0xFF78909C),
              500: Color(0xFF607D8B),
              600: Color(0xFF546E7A),
              700: Color(0xFF455A64),
              800: Color(0xFF37474F),
              900: Color(0xFF263238),
            },
          ),
        ),
        home:
            FirebaseApi.isSignedIn ? const HomeScreen() : const LoginScreen());
  }
}
