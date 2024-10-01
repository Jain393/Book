import 'package:bookapp/homepage.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool isvisible = true;


  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    String pattern = r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Phone Number Validation (10-12 digits)
  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    String pattern = r'^\d{10,12}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid phone number (10-12 digits)';
    }
    return null;
  }


  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    String pattern = r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Password must be at least 8 characters long, include an uppercase letter, a number, and a special character';
    }
    return null;
  }


  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Text(
                  "Welcome!",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                Text(
                  "Please sign up to continue!",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 25),
                // First Name
                Text(
                  "First Name",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  controller: _firstnameController,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                // Last Name (Optional)
                Text(
                  "Last Name",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  controller: _lastnameController,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 15),
                // Phone Number
                Text(
                  "Phone number",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  validator: validatePhoneNumber,
                ),
                SizedBox(height: 15),
                // Email
                Text(
                  "Email",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                ),
                SizedBox(height: 15),
                // Password
                Text(
                  "Password",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isvisible = !isvisible;
                        });
                      },
                      icon: Icon(isvisible ? Icons.visibility : Icons.visibility_off),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: isvisible,
                  validator: validatePassword,
                ),
                SizedBox(height: 15),
                // Confirm Password
                Text(
                  "Confirm Password",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  controller: _confirmpasswordController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isvisible = !isvisible;
                        });
                      },
                      icon: Icon(isvisible ? Icons.visibility : Icons.visibility_off),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: isvisible,
                  validator: validateConfirmPassword,
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 50,
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return Homepage(username: _firstnameController.text);
                          }));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Sign Up Successful!")),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: Colors.blue.shade900,
                        foregroundColor: Colors.white,
                      ),
                      child: Text("Sign Up", style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                // Login Option
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?", style: TextStyle(fontSize: 16)),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return Login();
                          }),
                        );
                      },
                      child: Text("Login", style: TextStyle(fontSize: 16, color: Colors.blue)),
                    ),
                  ],
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
