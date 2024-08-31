import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krishi/screens/authentication/reset_password_screen.dart';
import 'package:krishi/services/emailAuth_service.dart';

class EmailAuthScreen extends StatefulWidget {
  const EmailAuthScreen({Key? key}) : super(key: key);
  static const String id = 'emailAuth-screen';

  @override
  _EmailAuthScreenState createState() => _EmailAuthScreenState();
}

class _EmailAuthScreenState extends State<EmailAuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;
  bool _login = false;
  bool _loading = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final EmailAuthentication _service = EmailAuthentication();

  _validateEmail() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _validate = false;
        _loading = true;
      });
      _service
          .getAdminCredential(
        context: context,
        isLog: _login,
        password: _passwordController.text,
        email: _emailController.text,
      )
          .then((value) {
        setState(() {
          _loading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.blue.shade200,
                child: const Icon(
                  CupertinoIcons.person_alt_circle,
                  color: Colors.blue,
                  size: 60,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Enter to ${_login ? 'Login' : 'Register'}',
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Enter Email and Password to ${_login ? 'Login' : 'Register'} ',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Email';
                  }
                  final bool isValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
                  if (!isValid) {
                    return 'Enter valid email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 10),
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  suffixIcon: _validate
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _passwordController.clear();
                            setState(() {
                              _validate = false;
                            });
                          },
                        )
                      : null,
                  contentPadding: const EdgeInsets.only(left: 10),
                  labelText: 'Password',
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onChanged: (value) {
                  if (_emailController.text.isNotEmpty) {
                    if (value.length > 3) {
                      setState(() {
                        _validate = true;
                      });
                    } else {
                      setState(() {
                        _validate = false;
                      });
                    }
                  }
                },
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: const Text("Forgot Password?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),),
                  onPressed: (){
                    Navigator.pushNamed(context, PasswordResetScreen.id);
                  },
                ),
              ),
              Row(
                children: [
                  Text(_login ? 'New Account' : 'Already Has an account?'),
                  TextButton(
                    child: Text(
                      _login ? 'Register' : 'Login',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      setState(() {
                        _login = !_login;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: AbsorbPointer(
            absorbing: _validate ? false : true,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: _validate
                        ? WidgetStateProperty.all(
                            Theme.of(context).primaryColor)
                        : WidgetStateProperty.all(Colors.grey)),
                onPressed: () {
                  _validateEmail();
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: _loading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          _login ? 'Login' : 'Register',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                )),
          ),
        ),
      ),
    );
  }
}
