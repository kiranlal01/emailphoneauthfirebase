import 'package:emailphoneauthfirebase/emailverification/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebasefunction.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey:"AIzaSyAo8EZyGYsUOA92CR-fXLZU99qIAWH13bk",
          appId:"1:430327780539:android:f001a42906885fc98bc59e",
          messagingSenderId:"",
          projectId:"emailphoneauthfirebase"
      )
  );
  User? user = FirebaseAuth.instance.currentUser;
  runApp(MaterialApp(
    home: user == null ? MyLogin() : MyHome(),
  ));
}

class MyLogin extends StatelessWidget{
  var email_controller=TextEditingController();
  var pass_controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login",style: TextStyle(fontSize: 20),),),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: email_controller,
              decoration: InputDecoration(
                  hintText: 'email',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
              ),),
            TextField(
              controller: pass_controller,
              decoration: InputDecoration(
                  hintText: 'password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
              ),),
            ElevatedButton(onPressed: () {
              String email = email_controller.text.trim();
              String pass = pass_controller.text.trim();

              FireBaseHelper()
                  .loginUser(email:email,pass:pass)
                  .then((result){
                if (result == null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyHome()));
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result),backgroundColor: Colors.blue,));
                }
              });
            }, child: const Text("Login")),

            TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyRegister()));
            }, child: Text("Register"))
          ],
        ),
      ),
    );
  }

}