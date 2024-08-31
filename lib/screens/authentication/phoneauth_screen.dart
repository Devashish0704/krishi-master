
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krishi/services/phoneauth_service.dart';

class PhoneAuthScreen extends StatefulWidget {
  static const String id = 'phone-auth-screen';

  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  bool validate = false;
  var countryCodeController = TextEditingController(text: '+91');
  var phoneNumberController = TextEditingController();



  final PhoneAuthService _service =PhoneAuthService();





  @override
  Widget build(BuildContext context) {
    //Create an instance of ProgressDialog
    CircularProgressIndicator progressIndicator = CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
    );

    Widget progressDialog = AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          progressIndicator,
          SizedBox(height: 20),
          Text(
            'Please wait',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
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
              const Text(
                'Enter your Phone',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'We will send confirmation code to your Phone Number',
                style: TextStyle(color: Colors.grey),
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: TextFormField(
                        autofocus: true,
                        controller: countryCodeController,
                        enabled: false,
                        decoration: const InputDecoration(
                            counterText: '00', labelText: 'Country'),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 3,
                      child: TextFormField(
                        onChanged: (value) {
                          if (value.length == 10) {
                            setState(() {
                              validate = true;
                            });
                          } if(value.length<10){
                            validate=false;
                          }
                        },
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        controller: phoneNumberController,
                        decoration: const InputDecoration(
                          labelText: 'Number',
                          hintText: 'Enter your phone number',
                          hintStyle: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: AbsorbPointer(
            absorbing: validate  ? false : true,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: validate
                        ? WidgetStateProperty.all(
                            Theme.of(context).primaryColor)
                        : WidgetStateProperty.all(Colors.grey)),
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                  String number =
                      '${countryCodeController.text}${phoneNumberController.text}';
                  await _service.verifyPhoneNumber(context, number);
                  Navigator.of(context).pop(); // Dismiss the progress dialog
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Next',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
