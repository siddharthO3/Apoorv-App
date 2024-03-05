import 'package:apoorv_app/screens/homepage/feed/feed.dart';
import 'package:apoorv_app/screens/signup-flow/letsgo.dart';

import 'screens/homepage/homepage.dart';
import 'screens/homepage/Profile/profile.dart';
import 'screens/homepage/points/points.dart';
import 'screens/signup-flow/signup.dart';
import 'screens/signup-flow/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/homepage/shop/shop.dart';
import 'screens/homepage/points/leaderboard.dart';

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

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      routes: {
        WelcomeScreen.routeName: (context) => const WelcomeScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        HomePage.routeName: (context) => const HomePage(),
        PointsScreen.routeName: (context) => const PointsScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        Leaderboard.routeName: (context) => const Leaderboard(),
        LetsGoPage.routeName: (context) => const LetsGoPage(),
        ShopScreen.routeName: (context) => const ShopScreen(),
        FeedScreen.routeName: (context) => const FeedScreen(),
        
      },
      initialRoute: FeedScreen.routeName,
    );
  }
}
