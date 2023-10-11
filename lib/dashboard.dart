import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDashboard extends StatefulWidget {
  const MyDashboard({Key? key}) : super(key: key);

  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  logout()
  {
    _auth.signOut().then((value){
      Navigator.pushNamed(context, 'login');
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar : AppBar(
          title: Text('Dashboard'),
          actions: [
            InkWell(
                onTap: (){
                  logout();
                },
                child: Icon(Icons.logout,color: Colors.red.shade400,))
          ],
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            TextButton(onPressed: (){
              Navigator.pushNamed(context, 'CreateAd');
            }, child: const Text('Post an Ad', style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 18,
              color: Color(0xff4c505b),
            ),
            )),

            ElevatedButton(onPressed: (){Navigator.pushNamed(context, 'home');},
                child: const Center(child: Text("Homepage",style: TextStyle(color: Colors.white),
                ),
                )
            )


          ],
        ),





    ));


  }
}

