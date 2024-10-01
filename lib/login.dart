
import 'package:bookapp/signin.dart';
import 'package:flutter/material.dart';


import 'homepage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey=GlobalKey<FormState>(
  );

  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();


  bool isvisible = true;                  //to obscure the password text

  String? validateEmail(String? value) {                                //to validate email
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // Basic email pattern
    String pattern =
        r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+';                      //regular expression for email
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {                               //to validate password
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
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
            padding: const EdgeInsets.only(top: 130, right: 16, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                SizedBox(height: 40,),

                Text("Welcome back!", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),),
                Text("Please login to continue!", style: TextStyle( fontWeight: FontWeight.w700),),

                SizedBox(height: 70,),

                Text("Email", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(

                      border: OutlineInputBorder()
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,                                       //to validate email
                ),
                SizedBox(height: 10,),


                Text("Password", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(

                      suffixIcon: IconButton(onPressed: (){

                        setState(() {
                          isvisible = !isvisible;
                        });
                      }, icon: Icon(isvisible ? Icons.visibility : Icons.visibility_off) ),
                      border: OutlineInputBorder()
                  ),
                  obscureText:  isvisible ? true: false,
                  validator: validatePassword,                                         //to validate password
                ),


                SizedBox(
                  height: 40,
                ),


                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 50,
                    width: 120,
                    child: ElevatedButton(onPressed: (){

                      if(_formKey.currentState!.validate()){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return Homepage(username: '',);
                        }));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Successfull!")));
                      }

                    },style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                        backgroundColor: Colors.blue.shade900,
                        foregroundColor: Colors.white
                    ), child: Text("Login",style: TextStyle(fontSize: 18),)),
                  ),
                ),

                SizedBox(height: 35,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",style: TextStyle(fontSize: 16),),
                    SizedBox(width: 10,),
                    InkWell(onTap:() {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Signin();
                      }));
                    },child: Text("Sign up",style: TextStyle(fontSize: 16,color:Colors.blue),)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

