import 'package:apoorv_app/firebase_options.dart';
import 'package:apoorv_app/screens/homepage/homepage.dart';
import 'package:apoorv_app/screens/homepage/Profile/profile.dart';
import 'package:apoorv_app/screens/homepage/points/points_transfer.dart';
// import 'package:apoorv_app/screens/profile_2.dart';
import 'package:apoorv_app/screens/signup-flow/signup.dart';
import 'package:apoorv_app/screens/signup-flow/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './screens/homepage/points/points.dart';
import './screens/homepage/points/points_transfer.dart';

// Future<void> main() async {
//   await DotEnv().load(fileName: '.env');
//
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await Firebase.initializeApp(
//     options: await DefaultFirebaseOptions.currentPlatform,
//   );
//
//   runApp(const MyApp());
// }

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      routes: {
        WelcomeScreen.routeName:(context) => const WelcomeScreen(),
        SignUpScreen.routeName:(context) => SignUpScreen(),
        PointsScreen.routeName : (context) => const PointsScreen(),
        HomePage.routeName:(context) => const HomePage(),
        ProfileScreen.routeName:(context) => const ProfileScreen(),
        // Profile2.routeName:(context) => const Profile2(),
        PointsTransfer.routeName: (context) => const PointsTransfer(),
      },
      initialRoute: WelcomeScreen.routeName,
    );
  }
}
