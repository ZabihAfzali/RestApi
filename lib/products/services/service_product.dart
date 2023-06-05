import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_mplementation/utilities/rest_api_utilities.dart';

import '../model/model_post.dart';



class ServiceProduct{
  static var  client=http.Client();
  static var duration=Duration(seconds: 10);


  static Future<List<ModelPost>> loadProducts() async {
    List<ModelPost> list = [];

    try {
      Uri uri = Uri.parse('https://fakestoreapi.com/products');
      http.Response response = await client.get(
          Uri.parse(RestApiUtilities.product_url)).timeout(duration);

      Map<String, String> header = {};
      Map<String, String> body = {};

      RestApiUtilities.GetPrintHeaderBodyUrlResponse(header, body, RestApiUtilities.product_url, response,);

      if (response.statusCode == 200) {
        list = modelPostFromMap(response.body);
        return list;
      } else {
        print(" Response sss- ${RestApiUtilities.GetErrorResponse(response.statusCode)}");
        return list;
      }
    }on TimeoutException{
      print(RestApiUtilities.GetErrorResponse(430));
      return list;
    }
    on SocketException{
      print(RestApiUtilities.GetErrorResponse(420));
      return list;
    }
    catch (e){
      print("Error: ${e.toString()}");
      return list;
    }
  }

    }



