import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mychat/ui/pages/landing_page.dart';
import 'package:mychat/viewModel/user_view_model.dart';



import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'provider/get_it/locator.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => UserViewModel(),
      child: MaterialApp(
        title: 'MyChat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        //onGenerateRoute: RouteGenerator.route,
        home: const LandingPage(),
      ),
    );
  }
}



