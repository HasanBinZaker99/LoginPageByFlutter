import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lisst_view/view_data.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  MyApp({Key? key}): super(key:key);
  @override
  State<MyApp> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Future<void>    insertrecord() async {
    if(name.text != "" || email.text != "" || password.text != ""){
      try{
        String uri = "http://192.168.0.104/practice_api/insert_record.php";
        // String uri = "http://10.0.2.2/practice_api/insert_record.php";
        var res =await http.post(Uri.parse(uri),body: {
          "name":name.text,
          "email":email.text,
          "password":password.text,
        });
        var response = jsonDecode(res.body);
        if (response["success"] == "true"){
          print("Record Inserted");
          name.text="";
          email.text="";
          password.text="";
        }else{
          print("Some Issue");
        }
      }
          catch(e){
        print(e);
          }
    }
    else{
      print("please fill all fields");
    }
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          title: Text("Insert Record"),
        ),
        body: Column(children: [
          Container(
          margin: EdgeInsets.all(10),
          child: TextFormField(
            controller: name,
            decoration: InputDecoration(
              border: OutlineInputBorder(),label: Text('Enter the Name')),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: email,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),label: Text('Enter the Email')),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: password,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Enter the Password')),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: (){
                insertrecord();
              },
              child: Text('Insert'),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Builder(
              builder: (context){
                return ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => view_data()));
                    }, child: Text("View Data"));
              },
            ),

          )
        ]),
    ),
    );
  }

}
































