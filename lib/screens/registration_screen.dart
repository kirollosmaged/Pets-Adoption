import 'package:auth_system/model/user_model.dart';
import 'package:auth_system/screens/home_screen.dart';
import 'package:auth_system/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({ Key? key }) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth = FirebaseAuth.instance;
  
  final _formKey = GlobalKey<FormState>();

  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();


  @override
  Widget build(BuildContext context) {

    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.emailAddress,
       validator:(value){
        RegExp regex = new RegExp(r'^.{3,}$');
        if(value!.isEmpty){
          return("First Name cannot be empty");
        }
        if(!regex.hasMatch(value))
        {
          return("Enter Valid name(Minimum of 3)");
        }
        return null;

      },

      onSaved: (value){
        
        firstNameEditingController.text = value!;

      },
      
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "First Name",
        border: OutlineInputBorder(
          borderRadius:BorderRadius.circular(10)
        )
      ),
    
    );

    final secondNameField = TextFormField(
      autofocus:false,
      controller:secondNameEditingController,
      validator:(value){
        RegExp regex = new RegExp(r'^.{3,}$');
        if(value!.isEmpty){
          return("Second Name cannot be empty");
        }
        if(!regex.hasMatch(value))
        {
          return("Enter Valid name(Minimum of 3)");
        }
        return null;

      },

     
      onSaved:(value)
      {
        secondNameEditingController.text = value!;
      },

      textInputAction:TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Second Name",
        border: OutlineInputBorder(
          borderRadius:BorderRadius.circular(10)
        )
      ),
        
    );

     final emailField = TextFormField(
      autofocus:false,
      controller:emailEditingController,
       validator: (value){
        if(value!.isEmpty){
          return("Please Enter Your Email");
        }
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
          return("Please Enter a valid email");
        }
        return null;
      },
      
      
      onSaved:(value)
      {
        emailEditingController.text = value!;
      },

      textInputAction:TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius:BorderRadius.circular(10)
        )
      ),
        
    );

     final passwordField= TextFormField(
      autofocus:false,
      controller:passwordEditingController,
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
        passwordEditingController.text = value!;
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

     final confirmPasswordField = TextFormField(
      autofocus:false,
      controller:confirmPasswordEditingController,
      obscureText: true,
      validator:(value)
      {
        if(confirmPasswordEditingController.text != passwordEditingController.text)
        {
          return "Password dont match";
        }
        return null;
      },

      onSaved:(value)
      {
        confirmPasswordEditingController.text = value!;
      },

      textInputAction:TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password",
        border: OutlineInputBorder(
          borderRadius:BorderRadius.circular(10)
        )
      ),
        
    );

    final signUpButton= Material(
      elevation: 5.0,
      borderRadius:BorderRadius.circular(30),
      color:Colors.purple[800],
      child:MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: Text(
        "Sign Up",
        style: TextStyle(
          fontSize:20, 
          color:Colors.white,
          fontWeight: FontWeight.bold
        ),
        ),
      )
    );

   return Scaffold(
     backgroundColor: Colors.transparent,
     appBar: AppBar(
       elevation:0,
       leading: IconButton(
         icon:Icon(
           Icons.arrow_back,
           color:Colors.white
         ),
         onPressed:(){
           Navigator.of(context).pop();
         },
       ),
       backgroundColor:Colors.purple[700],
       centerTitle: true,
       title: Text(
         "Sign Up",
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
                    firstNameField,
                  SizedBox(
                     height:25
                   ),
                    secondNameField,
                  SizedBox(
                     height:25
                   ),                  
                  emailField,
                  SizedBox(
                     height:25
                   ),
                  passwordField,
                  SizedBox(
                     height:25
                   ),
                    confirmPasswordField,
                  SizedBox(
                     height:35
                   ),
                   signUpButton,
                   SizedBox(
                     height:15
                   ),
                   Row(
                     mainAxisAlignment:MainAxisAlignment.center,
                     children:<Widget>[
                       Text(
                         "Already have an account "
                       ),
                       GestureDetector(
                         onTap: (){
                           Navigator.push(
                             context,MaterialPageRoute(
                               builder:(context)=>
                                  LoginScreen()
                               
                             )
                           );
                         },
                         child:Text(
                           "Login",
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

  void signUp(String email, String password) async
  {
    if(_formKey.currentState!.validate()){
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
      .then((value) => {postDetailsToFirestore()})
      .catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });
    }

    
  }

  postDetailsToFirestore() async
    {
      //Calling our firestore
      //calling our user model

      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      User? user = _auth.currentUser;

      UserModel userModel = UserModel();

      //writeing all the values into db
      userModel.email = user!.email;
      userModel.uid = user.uid;
      userModel.firstName= firstNameEditingController.text;
      userModel.secondName = secondNameEditingController.text;
      
      await firebaseFirestore 
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
      Fluttertoast.showToast(
        msg:"Account created successfully!!!!"
      );

      Navigator.pushAndRemoveUntil(
        (context), 
        MaterialPageRoute(builder: (context)=> HomeScreen()), 
        (route) => false);


    }
}