import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trivo/database/functions/Firebase/db_manager.dart';
import 'package:trivo/firebase_options.dart';
import 'package:trivo/screens/screen_splash.dart';

const key_ = 'user in';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await Hive.initFlutter();
  // if (!Hive.isAdapterRegistered(DestinationAdapter().typeId)) {
  //   Hive.registerAdapter(DestinationAdapter());
  // }
  // ignore: unused_local_variable
  DataManager dataManager = DataManager();
  // dataManager.getData();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',
      theme: ThemeData(),
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) => snapshot.hasData
              ? GetStarted(
                  logedin: true,
                )
              : GetStarted(
                  logedin: false,
                )),
    );
  }
}
