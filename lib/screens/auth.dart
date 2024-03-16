import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();

  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _confirmPassword = '';
  var _obscurePassword = true;
  var _obscureConfirmPassword = true;

  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    final isValid = _form.currentState!.validate();

    if (isValid) {
      _form.currentState!.save();
      print(_enteredEmail);
      print(_enteredPassword);
      // if (!_isLogin && _enteredPassword != _confirmPassword) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text('Passwords do not match'),
      //     ),
      //   );
      //   return;
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 250,
                child: Image.asset('assets/images/water_splash.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Container(
                    color: Theme.of(context).colorScheme.background,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: _form,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                  labelText: 'Email Address'),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains('@')) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredEmail = value!;
                              },
                            ),
                            TextFormField(
                              controller: _passwordController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              obscureText: _obscurePassword,
                              validator: (passwordValue) {
                                if (passwordValue == null ||
                                    passwordValue.trim().length < 6) {
                                  return 'Password must be at least 6 characters long.';
                                }
                                return null;
                              },
                              onSaved: (passwordValue) {
                                _enteredPassword = passwordValue!;
                              },
                            ),
                            // if (!_isLogin)
                            //   TextFormField(
                            //     style: const TextStyle(color: Colors.white),
                            //     decoration: InputDecoration(
                            //       labelText: 'Confirm Password',
                            //       suffixIcon: IconButton(
                            //         icon: Icon(
                            //           _obscureConfirmPassword
                            //               ? Icons.visibility_off
                            //               : Icons.visibility,
                            //         ),
                            //         onPressed: () {
                            //           setState(() {
                            //             _obscureConfirmPassword =
                            //                 !_obscureConfirmPassword;
                            //           });
                            //         },
                            //       ),
                            //     ),
                            //     obscureText: _obscureConfirmPassword,
                            //     validator: (value) {
                            //       if (value == null || value.trim().isEmpty) {
                            //         return 'Please enter a valid password';
                            //       }
                            //       if (value.trim() != _enteredPassword.trim()) {
                            //         return 'Passwords do not match';
                            //       }
                            //       return null;
                            //     },
                            //     onSaved: (value) {
                            //       _confirmPassword = value!;
                            //     },
                            //   ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: _submit,
                              child: Text(_isLogin ? 'Login' : 'Signup'),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(_isLogin
                                  ? 'Create an account'
                                  : 'I already have an account'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
