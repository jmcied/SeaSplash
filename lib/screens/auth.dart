import 'dart:io';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sea_splash/main.dart';
import 'package:sea_splash/widgets/user_image_picker.dart';
import 'package:sea_splash/models/user.dart';

final formatter = DateFormat.yMd();
final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

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
  var _enteredUsername = '';
  var _obscurePassword = true;
  File? _selectedImage;
  var _isAuthenticating = false;
  final _passwordController = TextEditingController();
  DateTime? _selectedDateOfBirth;
  Category _selectedCategory = Category.beginner;

  // var _confirmPassword = '';
  // var _obscureConfirmPassword = true;

  void _datePicker() async {
    final now = DateTime.now();
    final initialDate = DateTime(now.year - 18, now.month, now.day);
    final firstDate = DateTime(now.year - 100, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDateOfBirth = pickedDate;
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid || !_isLogin && _selectedImage == null) {
      //ToDo Show error message
      return;
    }

    _form.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (_isLogin) {
        final userCredentials = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredentials.user!.uid}.jpg');

        await storageRef.putFile(_selectedImage!);
        final imageUrl = await storageRef.getDownloadURL();
        
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
          'username': _enteredUsername,
          'email': _enteredEmail,
          'image_url': imageUrl,
          'date_of_birth': _selectedDateOfBirth.toString(),
          'category': _selectedCategory.name,
        });
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        //..
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message ?? 'Authentication failed.'),
      ));
      setState(() {
        _isAuthenticating = false;
      });
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
                  top: 20,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                child: Text(
                  'SeaSplash',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
                //width: 250,
                //child: Image.asset('/assets/images/sandy_beach.png'),   //images broken
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
                            if (!_isLogin)
                              UserImagePicker(
                                onPickImage: (pickedImage) {
                                  _selectedImage = pickedImage;
                                },
                              ),
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
                            if (!_isLogin)
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                          labelText: 'Username'),
                                      enableSuggestions: false,
                                      textCapitalization:
                                          TextCapitalization.none,
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            value.trim().length < 4) {
                                          return 'Please enter a valid username (min 4 characters).';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _enteredUsername = value!;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                          ),
                                          _selectedDateOfBirth == null
                                              ? 'Date of Birth'
                                              : formatter.format(
                                                  _selectedDateOfBirth!),
                                        ),
                                        IconButton(
                                          onPressed: _datePicker,
                                          icon: Icon(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                            Icons.calendar_month,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(height: 10),
                            if (!_isLogin)
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Swim Level',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: DropdownButton(
                                        dropdownColor: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        value: _selectedCategory,
                                        items: Category.values
                                            .map(
                                              (category) => DropdownMenuItem(
                                                value: category,
                                                child: Text(
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary),
                                                  category.name.toUpperCase(),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            if (value == null) {
                                              return;
                                            }
                                            _selectedCategory = value;
                                          });
                                        }),
                                  ),
                                ],
                              ),

                            // if (!_isLogin)           //COMFIRM PASSWORD CHECK NOT WORKING
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
                            if (_isAuthenticating)
                              const CircularProgressIndicator(),
                            if (!_isAuthenticating)
                              ElevatedButton(
                                onPressed: _submit,
                                child: Text(_isLogin ? 'Login' : 'Signup'),
                              ),
                            if (!_isAuthenticating)
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
