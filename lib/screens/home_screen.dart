import 'package:auth_system/model/user_model.dart';
import 'package:auth_system/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
      .collection("users")
      .doc(user!.uid)
      .get()
      .then((value){
        this.loggedInUser = UserModel.fromMap(value.data());

        setState(() {
           
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[700],
        title: Text(
          "Welcome",
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding:EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 180,
                child:Image.asset(
                  "assets/logo.jpg",
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                "Weclome Back",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                  height:10.0
                ),
              Text(
                "${loggedInUser.firstName}  ${loggedInUser.secondName} ",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500
                ),
              ),
              Text(
                "${loggedInUser.email} ",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height:15),
              ActionChip(
                label: Text("Logout"), 
                onPressed: (){
                  logout(context);
                }
                )

            ],
          ),
        ),
      ),
    );
  }

  Future <void> logout(BuildContext context) async
  {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginScreen() )
    );
  }
}