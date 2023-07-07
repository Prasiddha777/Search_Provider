import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_api/providers/pets_provider.dart';
import 'package:search_api/providers/user_provider.dart';
import 'package:search_api/screens/home_page.dart';
import 'package:search_api/screens/second_try_page.dart';
// import 'package:search_api/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PetsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SecondTryPage(),
      ),
    );
  }
}
