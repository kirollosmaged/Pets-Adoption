import 'dart:ffi';

import 'package:auth_system/screens/home_screen.dart';
import 'package:auth_system/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        if(value!.isEmpty){
          return("Please Enter Your Email");
        }
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
          return("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value){
        
        emailController.text = value!;

      },
      
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius:BorderRadius.circular(10)
        )
      ),
    
    );

    final passwordField = TextFormField(
      autofocus:false,
      controller:passwordController,
      obscureText: true,
      validator:(value){
        RegExp regex = new RegExp(r'^.{6,}$');
        if(value!.isEmpty){
          return("Password is required for login");
        }
        if(!regex.hasMatch(value))
        {
          return("Please Enter Valid Password(Min. 6 Character");
        }

      },

      onSaved:(value)
      {
        passwordController.text = value!;
      },

      textInputAction:TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius:BorderRadius.circular(10)
        )
      ),
        
    );

    final loginButton= Material(
      elevation: 5.0,
      borderRadius:BorderRadius.circular(30),
      color:Colors.purple[800],
      child:MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          signIn(emailController.text ,passwordController.text);
          /*Navigator.push(
            context, MaterialPageRoute(
              builder:(context)=>HomeScreen()
            )
          );*/
        },
        child: Text(
        "Login",
        style: TextStyle(
          fontSize:20, 
          color:Colors.white,
          fontWeight: FontWeight.bold
        ),
        ),
      )
    );


    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.purple[700],
        centerTitle: true,
       title:  Text(
         "Login",
         style:TextStyle(
           fontSize:21.0,
           fontWeight: FontWeight.bold,           
         )
       ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color:Colors.white,
            child: Padding(
              padding: EdgeInsets.all(36.0),
              child:Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:
                 <Widget>[
                   SizedBox(
                     height: 200,
                     
                     child:Image.asset(
                       "assets/logo.jpg",
                       fit:BoxFit.contain,
                       height:120.0,
                       width:150.0
                     )
                     /*
                     child:Text(
                       "Auth System",
                       style:TextStyle(
                         fontSize:30.0,
                         fontWeight:FontWeight.bold,
                         color:Colors.purple[700]
                       )
                     )*/
                   ),
                   SizedBox(height: 45,),                   
                  emailField,
                  SizedBox(
                     height:25
                   ),
                  passwordField,
                  SizedBox(
                     height:35
                   ),
                   loginButton,
                   SizedBox(
                     height:15
                   ),
                   Row(
                     mainAxisAlignment:MainAxisAlignment.center,
                     children:<Widget>[
                       Text(
                         "Don't have an account? "
                       ),
                       GestureDetector(
                         onTap: (){
                           Navigator.push(
                             context,MaterialPageRoute(
                               builder:(context)=>
                                  RegistrationScreen()
                               
                             )
                           );
                         },
                         child:Text(
                           "SignUp",
                           style:TextStyle(
                             color:Colors.redAccent,
                             fontWeight:FontWeight.w600,
                             fontSize:15,
                           )
                         )
                       )
                     ]
                   )
                ],
              ),
            )
            ),
          ),
        ),
      ),
      
    );
  }

  //Login Furnction

void signIn(String email, String password) async
{
  if(_formKey.currentState!.validate())
  {
    await _auth.signInWithEmailAndPassword(email: email, password: password)
    .then((uid) =>{
      Fluttertoast.showToast(msg: "Login Successful"),
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder:(context) =>HomeScreen()
        )
      )
    })
    .catchError((e){
      Fluttertoast.showToast(msg: e!.message);
    });
    
    
  }
}
}


