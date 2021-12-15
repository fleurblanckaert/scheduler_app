import 'package:flutter/material.dart';

import 'calender.dart';


class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Scaffold(

          // appBar:  AppBar(
          //   backgroundColor: Color(0x008037),
          //   centerTitle: true,
          //   title:  const Text("Quiz App",style: TextStyle(
          //       fontSize: 25.0, color: Colors.white
          //   ),),
          // ),

          body:  Container(


            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: const Text("Welcome to Sprint Schedule",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,color:Colors.blue,
                    ),),),

                SizedBox(height:50),


                SizedBox(height: 30),
                Container(

                    child: Center(

                      child: RaisedButton(

                          padding:  EdgeInsets.only(left:40, right: 40, bottom: 15, top: 15),
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: const Text('Get started',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0
                          ),),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyHomePage(title: 'Flutter Demo Home Page')));
                          }
                      ),

                    )
                ),
              ],
            ),
          ),

        )
    );

  }
}