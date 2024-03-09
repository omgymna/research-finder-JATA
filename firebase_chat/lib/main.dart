import 'package:firebase_chat/firebase_options.dart';
import 'package:firebase_chat/services/auth/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget{
  const MyApp ({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
    theme: ThemeData(scaffoldBackgroundColor: Colors.white,),
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  } 


}
