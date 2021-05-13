import 'package:flutter/material.dart';
import 'package:node_todo/model/todo_model.dart';
import 'package:node_todo/network/todo_network.dart';
import 'addTodo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future data;
  
  @override
  void initState() { 
    super.initState();
    
    PostNetwork network = PostNetwork();
    data = network.fetchData();
  }
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("TODO"),
          centerTitle: true,
        ),
        body: Container(
            child: FutureBuilder<Posts>(
              future: data,
              // ignore: missing_return
              builder: (context, AsyncSnapshot<Posts> snapshots){
                if (snapshots.hasData) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: snapshots.data.data.length,
                  itemBuilder: (context, index){
                    var newdata = snapshots.data.data[index];
                    return Container(
                      
                      margin: EdgeInsets.all(10),
                      height: 150,
                      color: Colors.grey[400],
                      child: Card(
                        elevation: 50,
                        child: ListTile(
                          trailing: IconButton(
                            color: Colors.white,
                            icon: Icon(Icons.delete), 
                            onPressed: (){
                              PostNetwork deleteData = PostNetwork();
                              deleteData.deleteData(newdata.id);

                              setState(() {
                                snapshots.data.data.removeAt(index);             
                              });
                            }),
                        title: Text(newdata.title),
                        subtitle: Text(newdata.description),
                        // onTap: (){
                        //   PostNetwork deleteData = PostNetwork();
                        //   deleteData.deleteData(newdata.id);
                        // },
              
                      ))
                    );
                  },
                );
                }else {
                  return Center(
                    child: Container(
                      width: 50,
                      child: LinearProgressIndicator()
                    )
                  );
                }
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: (){
            showInputArea(context);
          },
        ),
      ),
    );

  }
}
