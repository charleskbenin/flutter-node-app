import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:node_todo/model/todo_model.dart';


final httpClient = http.Client();

Map<String, String> customHeader = {
  "Accept": "application/json",
  "Content-type": "application/json; charset=UTF-8"
};

List<Posts> _posts = [];

List<Posts> get posts{
  return [..._posts];
}

class PostNetwork{
  
  Future<Posts>fetchData() async{
    final url = 'https://nodeservertestapi.herokuapp.com/';
    final response = await httpClient.get(Uri.parse(url));

    final data = json.decode(response.body);
    print(response.body);

    if (response.statusCode == 200) {
      return Posts.fromJson(data);
    }
    else {
      throw {
        Exception('Cant find data from $url')
      };
    }

  }

  // // PostData
  Future postData(Map postData) async{
    final url = 'https://nodeservertestapi.herokuapp.com/add';
    final response = await httpClient.post(Uri.parse(url), 
    headers: customHeader,
    body: jsonEncode(postData)
    );
    print(response.body);
  }

  Future deleteData(String id) async {
    String url = 'https://nodeservertestapi.herokuapp.com/delete';
    final response = await httpClient.delete(Uri.parse(url),
      headers: customHeader,
      body: jsonEncode({"title": id})
    );
    print(response.body);
    
  }

  Future updateData(String id) async {
    String url = 'https://nodeservertestapi.herokuapp.com/update';
    final response = await httpClient.put(Uri.parse(url),
    headers: customHeader,
    body: jsonEncode({"id": id}));
    print(response.body);
  }
}

