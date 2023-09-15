import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_office_project/components/common_button.dart';
import 'package:sample_office_project/provider/auth_provider.dart';
import 'package:sample_office_project/utils/constants.dart';
import 'package:sample_office_project/utils/helper.dart';
import 'package:sample_office_project/utils/styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = true;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 550.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    login,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 36.0),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (value) => (value!.isEmpty)
                        ? emailRequired
                        : !isValidEmail(value)
                            ? emailInvalid
                            : null,
                    style: const TextStyle(color: Colors.white),
                    decoration: kTextFieldDecoration.copyWith(hintText: email),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) =>
                        (value!.isEmpty) ? passwordRequired : null,
                    style: const TextStyle(color: Colors.white),
                    obscureText: _passwordVisible,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: password,
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white54,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  CommonButton(
                    title: login,
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        try {
                          await context
                              .read<AuthProvider>()
                              .addToken(_emailController.text);
                        } catch (e) {
                          if (!mounted) return;
                          await infoDialog(context, e.toString(), 'Ok');
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
