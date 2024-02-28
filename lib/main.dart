import 'package:apoorv_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './screens/points/points.dart';
import './screens/points/points_transfer.dart';

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

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      initialRoute: 'points',
      routes: {
        'points': (context) => const PointsScreen(),
        'points_transfer': (context) => const PointsTransfer(),
      },
    );
  }
}