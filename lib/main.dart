import 'package:apoorv_app/screens/homepage/feed/feed.dart';
import 'package:apoorv_app/screens/homepage/Transactions/payment.dart';
import 'package:apoorv_app/screens/homepage/Transactions/payment_success.dart';
import 'package:apoorv_app/screens/shopkeeper/shopkeeper_homepage.dart';
import 'package:apoorv_app/screens/shopkeeper/shopkeeper_points.dart';
import 'package:apoorv_app/screens/shopkeeper/shopkeeper_profile.dart';
import 'package:apoorv_app/screens/shopkeeper/shopkeeper_signup.dart';
import 'package:apoorv_app/screens/signup-flow/letsgo.dart';
import 'package:apoorv_app/widgets/provider/shopkeeper_info_provider.dart';
import 'package:apoorv_app/widgets/provider/user_info_provider.dart';
import 'package:provider/provider.dart';

import 'screens/homepage/homepage.dart';
import 'screens/homepage/Profile/profile.dart';
import 'screens/homepage/points/points.dart';
import 'screens/signup-flow/signup.dart';
import 'screens/signup-flow/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/homepage/points/leaderboard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(create: (context) => ShopkeeperProvider()),
      ],
      child: MaterialApp(
        restorationScopeId: "root",
        theme: ThemeData.dark(useMaterial3: true),
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
          FeedScreen.routeName: (context) => const FeedScreen(),
          Payment.routeName: (context) => const Payment(),
          PaymentSuccess.routeName: (context) => const PaymentSuccess(),
          ShopkeeperHomePage.routeName: (context) => const ShopkeeperHomePage(),
          ShopkeeperPointsScreen.routeName: (context) =>
              const ShopkeeperPointsScreen(),
          ShopkeeperProfileScreen.routeName: (context) =>
              const ShopkeeperProfileScreen(),
          ShopkeeperSignupScreen.routeName: (context) =>
              const ShopkeeperSignupScreen(),
        },
        initialRoute: WelcomeScreen.routeName,
      ),
    );
  }
}
