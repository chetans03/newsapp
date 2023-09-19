import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:napp/services/googlesign.dart';

final _firebaseauth = FirebaseAuth.instance;

class auth extends StatefulWidget {
  auth({super.key});

  @override
  State<auth> createState() => _authState();
}

class _authState extends State<auth> {
  bool _login = true;
  var _emailcontroller = '';
  var _passwordcontroller = '';

  final _formkey = GlobalKey<FormState>();
  bool _isauth = false;
  bool googleauth = false;

  void _save() async {
    final isvlaid = _formkey.currentState!.validate();

    if (isvlaid) {
      _formkey.currentState!.save();
    } else {
      return;
    }

    try {
      setState(() {
        _isauth = true;
      });

      if (!_login) {
        final UserCres = await _firebaseauth.createUserWithEmailAndPassword(
            email: _emailcontroller, password: _passwordcontroller);
      } else {
        final logincred = await _firebaseauth.signInWithEmailAndPassword(
            email: _emailcontroller, password: _passwordcontroller);
      }
    } on FirebaseAuthException catch (e) {
      _isauth = true;
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error"),
              actions: [
                Column(
                  children: [
                    Text(e.message!),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, "OK");
                      },
                      child: Text("OK"),
                    ),
                  ],
                )
              ],
            );
          });
    }

    setState(() {
      _isauth = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 0, 0, 0),
            Color.fromARGB(255, 18, 18, 23)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Container(
                height: 500,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                  color: Color.fromARGB(255, 230, 225, 225),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(right: 20, left: 20, top: 40),
                          child: Text(
                            _login ? "Log In" : "Sign Up",
                            style: GoogleFonts.roboto(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              Row(children: [
                                Icon(Icons.person),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2.0)),
                                      ),
                                      hintText: "xyz@gmail.com",
                                      labelText: "Enter email",
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty ||
                                          !value.contains("@gmail.com")) {
                                        return "Please enter correct email address";
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _emailcontroller = value!;
                                    },
                                  ),
                                ),
                              ]),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(children: [
                                Icon(Icons.lock),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2.0)),
                                      ),
                                      labelText: "Enter password",
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().length < 6) {
                                        return "Please enter atleast 6 characters";
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _passwordcontroller = value!;
                                    },
                                  ),
                                ),
                              ]),
                              const SizedBox(
                                height: 20,
                              ),
                              _isauth
                                  ? const SpinKitCircle(
                                      size: 40,
                                      color: Color.fromARGB(255, 17, 17, 17),
                                    )
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          foregroundColor: Color.fromARGB(
                                              255, 255, 255, 255),
                                          backgroundColor: const Color.fromARGB(
                                              255, 2, 2, 2)),
                                      onPressed: () {
                                        _save();
                                      },
                                      child: Text(
                                        _login ? "Login" : "Create Account",
                                        style: GoogleFonts.albertSans(
                                            fontSize: 20),
                                      ),
                                    ),
                              Container(
                                height: 1,
                                width: 400,
                                color: Colors.black,
                              ),
                              _isauth
                                  ? const Text("")
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Color.fromARGB(
                                              255, 255, 253, 253),
                                          foregroundColor:
                                              Color.fromARGB(255, 0, 0, 0)),
                                      onPressed: () {
                                        setState(() {
                                          _login = !_login;
                                        });
                                      },
                                      child: Text(
                                        _login
                                            ? "Don't have an account"
                                            : "Already have an account!",
                                        style: GoogleFonts.albertSans(
                                            fontSize: 20),
                                      ),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Authgoogle().signinwithgoogle();
                                    },
                                    child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Image.asset("images/google.png"),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
