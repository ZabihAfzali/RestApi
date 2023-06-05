import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_mplementation/products/services/service_product.dart';

import '../../utilities/rest_api_utilities.dart';
import '../model/model_post.dart';



class Home extends StatefulWidget {

  Home(){

  }

  @override
  Widget build(BuildContext context){
    return Container();
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

var client = http.Client();

class _MyHomePageState extends State<MyHomePage> {
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
      _future_list=ServiceProduct.loadProducts();
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

       // child: RestApiUtilities.ShowLoadingView(context),

         child: FutureBuilder(
           future: _future_list,
           builder: (BuildContext context, AsyncSnapshot<List<ModelPost>> snapshot){
             if(snapshot.connectionState==ConnectionState.waiting){
               return Center(child: RestApiUtilities.ShowLoadingView(context));
             }
             else if(snapshot.connectionState==ConnectionState.done){
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
             }
            return Text("data");
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

  }}