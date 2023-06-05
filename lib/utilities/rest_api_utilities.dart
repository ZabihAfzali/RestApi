import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';



class RestApiUtilities{
  static final String url="https://fakestoreapi.com/products";
  static String product_url="$url";

  static final error_404="resource not found";
  static final error_401="Un authorize error found";
  static final error_internet_issue="Internet issue";
  static final error_time_out="Time out  issue";
  static final error_unknown="unknown error";

  static String GetErrorResponse(int status){
    switch(status){
      case 404:
        return error_404;
      case 401:
        return error_401;
      case 420:
        return error_internet_issue;
      case 430:
        return error_time_out;
      default:
        return error_unknown;
    }
  }

  static void GetPrintHeaderBodyUrlResponse(header,body,url,response){
    print("Get Response: url $url");
    print("Get Response: header $header");
    print("Get Response: body $body");
    print("Get Response: response ${response.statusCode} ,  ${response.body} ");
  }

  static Widget ShowLoadingView(BuildContext context){
    return Container(
      width: 145,
      height: 145,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        children: [
          SizedBox(
            width: 88,
            height: 88,
            child: Lottie.asset("assets/jsons/lottie_loading.json"),
          ),
          SizedBox(height: 10,),
          Text("Loading data",style: TextStyle(
            fontSize: 10,
          ),),

        ],
      ),
    );
  }

}