import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_mplementation/products/model/model_post.dart';
import 'package:rest_api_mplementation/products/screen/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '',),
    );
  }
}

class MyHomePageM extends StatefulWidget {
  const MyHomePageM({super.key, required this.title});

  final String title;

  @override
  State<MyHomePageM> createState() => _MyHomePageMState();
}

var client = http.Client();

class _MyHomePageMState extends State<MyHomePageM> {
  int _counter = 0;

  late Future<List<ModelPost>> _future_list;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _future_list=loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("API's"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: FutureBuilder(
          future: _future_list,
          builder: (context, AsyncSnapshot<List<ModelPost>> snapshot){
            if(snapshot.hasError){
              return Text("${snapshot.error}");
            }
            else if(snapshot.hasData){
              List<ModelPost> list=snapshot.data!;
              if(list.length>0){
                return ListView.builder(itemCount: list.length,itemBuilder: (context,index){
                  return ListTile(
                    title: Text("${list[index].title}"),
                    subtitle: Text("${list[index].description}"),
                  );
                });
              }else{
                return Text("Sorry record not found");
              }

            }
            else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
        },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<List<ModelPost>> loadData() async {
    Uri uri = Uri.parse('https://fakestoreapi.com/products');
    List<ModelPost> list = [];
    http.Response response = await client.get(uri);

    if (response.statusCode == 200) {
      list = modelPostFromMap(response.body);
      return list;
    } else {
      return list;
    }

}
}
