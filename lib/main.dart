import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sample_office_project/provider/auth_provider.dart';
import 'package:sample_office_project/repository/auth_repository.dart';
import 'package:sample_office_project/screens/splash_screen.dart';
import 'package:sample_office_project/utils/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final _storage = const FlutterSecureStorage();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kPrimary,
        textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: kSecondary,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AuthProvider(
              authRepository: AuthRepository(storage: _storage),
            ),
          ),
        ],
        child: const SplashScreen(),
      ),
    );
  }
}
