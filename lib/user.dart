import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; 

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List users;
  Map datas;
  Future setUser() async{
    String url = "https://reqres.in/api/users";
    http.Response response = await http.get(url);
    datas = json.decode(response.body);
    setState(() {
      users = datas["data"];
    });
  }

 @override
  void initState() {
    super.initState();
    setUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("User",style: TextStyle(color: Colors.pink,fontSize: 40.0),),
         centerTitle: true,
         actions: <Widget>[
           Icon(Icons.group),
         ],
       ),
       drawer: Drawer(
         child: ListView(
           children: <Widget>[
             DrawerHeader(
              child: Text("Moblie app",style: TextStyle(color: Colors.pink,fontSize: 30.0),), 
             decoration: BoxDecoration(
               color: Colors.teal,
             )
             ),
           ],
         ),
         
       ),
    
       body: ListView.builder(
         itemCount: users == null ? 0 : users.length,
         itemBuilder:(BuildContext context ,int i){
           final user = users[i];
           return Card(
            child: Container(
             padding: EdgeInsets.all(20.0),
             child:Row(
               children: <Widget>[
                 CircleAvatar(
                   backgroundImage: NetworkImage("${user["avatar"]}"),
                 ),
                 SizedBox(width:  20.0,),
                 Text("${user["first_name"]}"),
               ],
             ),
           ),
           );
         } ,
       ),
    );
  }
}