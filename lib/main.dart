import 'package:apoorv_app/constants.dart';
import 'package:apoorv_app/providers/shopkeeper_provider.dart';
import 'package:apoorv_app/screens/homepage/Maps/maps_full_view.dart';
import 'package:apoorv_app/shop_router.dart';
import 'package:apoorv_app/shopkeeper/shopkeeper_homepage.dart';
import 'package:apoorv_app/shopkeeper/shopkeeper_points_screen.dart';
import 'package:apoorv_app/shopkeeper/shopkeeper_profile_screen.dart';
import 'package:apoorv_app/shopkeeper/shopkeeper_signup.dart';
import 'package:apoorv_app/shopkeeper/shopkeeper_welcome.dart';

import 'base_client.dart';
import 'providers/receiver_provider.dart';
import 'router.dart';
import 'screens/homepage/Profile/profile_2.dart';
import 'screens/homepage/Transactions/payment.dart';
import 'screens/homepage/Transactions/payment_success.dart';
import 'screens/homepage/points/all_transactions.dart';
import 'screens/signup-flow/letsgo.dart';
import 'providers/user_info_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'screens/homepage/homepage.dart';
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
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
        ChangeNotifierProvider(
          create: (context) => ReceiverProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ShopkeeperProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Raleway',
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Constants.blackColor,
          navigationBarTheme: const NavigationBarThemeData(
            backgroundColor: Constants.blackColor,
            surfaceTintColor: Constants.blackColor,
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
          ),
          filledButtonTheme: FilledButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return const Color(0xff494949);
                  } else {
                    return Constants.redColor;
                  }
                },
              ),
              foregroundColor:
                  MaterialStateProperty.all<Color>(Constants.whiteColor),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Constants.redColor),
              foregroundColor:
                  MaterialStateProperty.all<Color>(Constants.whiteColor),
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Constants.redColor,
            foregroundColor: Constants.whiteColor,
          ),
          textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.black),
              labelLarge: TextStyle(fontWeight: FontWeight.bold)),
        ),
        // restorationScopeId: "root",
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        routes: {
          Routing.routeName: (context) => const Routing(),
          WelcomeScreen.routeName: (context) => const WelcomeScreen(),
          SignUpScreen.routeName: (context) => const SignUpScreen(),
          HomePage.routeName: (context) => const HomePage(),
          MapsFullView.routeName: (context) => const MapsFullView(),
          PointsScreen.routeName: (context) => const PointsScreen(),
          Profile2Screen.routeName: (context) => const Profile2Screen(),
          Leaderboard.routeName: (context) => const Leaderboard(),
          LetsGoPage.routeName: (context) => const LetsGoPage(),
          Payment.routeName: (context) => const Payment(),
          PaymentSuccess.routeName: (context) => const PaymentSuccess(),
          AllTransactions.routeName: (context) => const AllTransactions(),
          
          ShopkeeperRouting.routeName:(context) =>  const ShopkeeperRouting(),
          ShopKeeperWelcomeScreen.routeName:(context) => const ShopKeeperWelcomeScreen(),
          ShopkeeperSignIn.routeName:(context) => const ShopkeeperSignIn(),
          ShopkeeperHomePage.routeName: (context) => const ShopkeeperHomePage(),
          ShopkeeperPointsScreen.routeName: (context) =>
              const ShopkeeperPointsScreen(),
          ShopkeeperProfileScreen.routeName: (context) =>
              const ShopkeeperProfileScreen(),
        },
        initialRoute: ShopkeeperRouting.routeName,
        // initialRoute: WelcomeScreen.routeName,
        // home: const LoadingScreen(),
      ),
    );
  }
}
