import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_office_project/provider/auth_provider.dart';
import 'package:sample_office_project/screens/login_screen.dart';
import 'package:sample_office_project/screens/project_screen.dart';
import 'package:sample_office_project/utils/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => context.read<AuthProvider>().getToken());
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return auth.loading
        ? const Center(
            child: CircularProgressIndicator(
              color: kSecondary,
            ),
          )
        : auth.token != null
            ? const ProjectScreen()
            : const LoginScreen();
  }
}
