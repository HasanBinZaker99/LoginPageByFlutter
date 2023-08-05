import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:flutter/cupertino.dart';

class view_data extends StatefulWidget{
  view_data({Key? key}) : super(key: key);

  @override
  State<view_data> createState() => _view_dataState();
}
class _view_dataState extends State<view_data> {
  List userdata=[];

  // set up the buttons

  // void showAlert(QuickAlertType confirm){
  //   QuickAlert.show(
  //     context: context,
  //     type: QuickAlertType.confirm,
  //     text: 'Do you want to delete it?',
  //     confirmBtnText: 'Yes',
  //     cancelBtnText: 'No',
  //
  //
  //     confirmBtnColor: Colors.green,
  //   );
  // }
  Future<void> delrecord(String id) async{
    try{
      String uri = "http://192.168.0.104/practice_api/delete_data.php";
      var res = await http.post(Uri.parse(uri),body: {"id":id});
      var response = jsonDecode(res.body);
      if(response["success"] == "true")
        {
          print("Record Deleted");
          getrecord();
        }else{
        print("Some issue");
      }
    }catch(e){print(e);}
  }

  Future<void> getrecord() async{
    String uri = "http://192.168.0.104/practice_api/view_data.php";
    try{
      var response = await http.get(Uri.parse(uri));
      setState(() {
        userdata = jsonDecode(response.body);
      });
    }
    catch(e){
      print(e);
    }
  }

  @override
  void initState(){

    getrecord();
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    // set up the buttons
    return Scaffold(
      appBar: AppBar(title: Text("View Data")),
      body: ListView.builder(
          itemCount: userdata.length,
          itemBuilder: (context,index)
      {
        return Card(
          margin: EdgeInsets.all(10),
          child: ListTile(
            title: Text(userdata[index]["uname"]),
            subtitle: Text(userdata[index]["uemail"]),
            //vdense:Text(userdata[index]),
            trailing:IconButton(
              icon:Icon(Icons.delete),
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (context) {
                    return Container(
                      child: AlertDialog(
                        title: Text("Are you sure?"),
                        actions: [
                          TextButton(
                              onPressed: (){
                                delrecord(userdata[index]["uid"]);
                                Navigator.pop(context);
                              }, child: Text("Yes"),
                             ),
                          TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            }, child: Text("No"),
                          ),
                        ],
                      ),
                    );
                    });
              },
            )

                // ElevatedButton(onPressed: (){
                //   showAlert(QuickAlertType.confirm);
                //
                //     //delrecord(userdata[index]["uid"]);
                //
                //
                // },child: const Text("confirm Alert"),
                // )
               // delrecord(userdata[index]["uid"]);



          ),
        );
      }
      ),
    );
  }

}































