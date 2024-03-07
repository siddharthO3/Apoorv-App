import 'package:apoorv_app/base_client.dart';
import 'package:apoorv_app/screens/homepage/Transactions/payment.dart';
import 'package:apoorv_app/screens/homepage/Transactions/payment_success.dart';
import 'package:apoorv_app/screens/signup-flow/letsgo.dart';
import 'package:apoorv_app/providers/user_info_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'screens/homepage/homepage.dart';
import 'screens/homepage/Profile/profile.dart';
import 'screens/homepage/points/points.dart';
import 'screens/signup-flow/signup.dart';
import 'screens/signup-flow/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/homepage/points/leaderboard.dart';

Future<void> main() async {
  await DotEnv().load(fileName: '.env');

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: await DefaultFirebaseOptions.currentPlatform,
  );

  BaseClient(dotenv.get('BASE_URL'));
  // FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //   if (user == null) {
  //     print('User is currently signed out!');
  //   } else {
  //     print('User is signed in!');
  //   }
  // });

  runApp(const MyApp());
}

// void main() {
//   runApp(const MyApp());
// }

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
      ],
      child: MaterialApp(
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
          Payment.routeName: (context) => const Payment(),
          PaymentSuccess.routeName: (context) => const PaymentSuccess(),
        },
        initialRoute: WelcomeScreen.routeName,
      ),
    );
  }
}
