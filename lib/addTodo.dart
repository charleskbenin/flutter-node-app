import 'package:flutter/material.dart';

import 'network/todo_network.dart';

Future postData;
TextEditingController titleController = TextEditingController();
TextEditingController desController = TextEditingController();
showInputArea(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Add Post"),
            content: Container(
              height: 300,
              width: 300,
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(hintText: 'Title'),
                    controller: titleController,
                  ),
                  SizedBox(),
                  TextField(
                    decoration: InputDecoration(hintText: 'Description'),
                    controller: desController,
                  ),
                  SizedBox(),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.black87,
                    ),
                    onPressed: () async {
                      if (titleController.text.isNotEmpty &&
                          desController.text.isNotEmpty) {
                        PostNetwork dataPost = PostNetwork();
                        postData = await dataPost.postData({
                          "title": titleController.text,
                          "description": desController.text,
                        });
                        Navigator.of(context).pop();   
                      }
                      desController.clear();
                      titleController.clear();
                    }
                  ), 
                ],
              ),
            ),
          ));
}

















// Container(
//           child: FutureBuilder<Posts>(
//             future: data,
//             // ignore: missing_return
//             builder: (context, AsyncSnapshot<Posts> snapshots){
//               if (snapshots.hasData) {
//                 return ListView.builder(
//                 itemCount: snapshots.data.data.length,
//                 itemBuilder: (context, index){
//                   var newdata = snapshots.data.data[index];
//                   return Container(
//                     margin: EdgeInsets.only(left: 20, right: 20, top: 20),
//                     height: 100,
//                     width: 20,
//                     color: Colors.blue,
//                     child: Card(child: ListTile(
//                       title: Text(newdata.title),
//                       onLongPress: (){

//                       },
//                     ))
//                   );
//                 },
//               );
//               }else {
//                 return Center(
//                   child: Container(
//                     width: 50,
//                     child: LinearProgressIndicator()
//                   )
//                 );
//               }
//             }
//           ),
//         ),










