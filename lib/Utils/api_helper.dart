import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_casino/Utils/toast.dart';

class GlobalFunction {
  bool playBackgroundMusic=false;
  ///post api
  static Future<String> apiPostRequest(url, data) async {
    String result = "";
    http.Response response =
        await http.post(Uri.parse(url), body: jsonEncode(data), headers: {
      'content-type': 'application/json',
      // 'X-Api-Key': Settings.apiKey,
    });
    if (response.statusCode == 200) {
      result = response.body;
      log(response.body);
    } else {}
    return result;
  }

  static Future<String> apiPostRequestToken(url, data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String result = "";
    // print("Token--->" + token);
    http.Response response =
        await http.post(Uri.parse(url), body: jsonEncode(data), headers: {
      'content-type': 'application/json',
      "Authorization": "Bearer ${preferences.getString("token")}",
    });
    if (response.statusCode == 200) {
      result = response.body;
    } else {
      log("-->${response.body}");
    }
    return result;
  }

  static Future<String> apiPostRequestTokenForBet(
    url,
    data,
    context,
    TextEditingController textController,

  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String result = "";
    // print("Token--->" + token);
    http.Response response =
        await http.post(Uri.parse(url), body: jsonEncode(data), headers: {
      'content-type': 'application/json',
      "Authorization": "Bearer ${preferences.getString("token")}",
    });
    if (response.statusCode == 200) {
      result = response.body;
    } else {
      textController.clear();
   

      DialogUtils.showOneBtn(
          context, jsonDecode(response.body)['message'], true);
    }
    return result;
  }

  static Future<String> apiPostRequestTokenForBetPortrait(
    url,
    data,
    context,
    TextEditingController textController,

  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String result = "";
    // print("Token--->" + token);
    http.Response response =
        await http.post(Uri.parse(url), body: jsonEncode(data), headers: {
      'content-type': 'application/json',
      "Authorization": "Bearer ${preferences.getString("token")}",
    });
    if (response.statusCode == 200) {
      result = response.body;
    } else {
      textController.clear();
   

      DialogUtils.showOneBtnPortrait(
          context, jsonDecode(response.body)['message'],true);
    }
    return result;
  }

  static Future<String> apiPostRequestTokenForUsers(
    url,
    data,
    context,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String result = "";
    // print("Token--->" + token);
    http.Response response =
        await http.post(Uri.parse(url), body: jsonEncode(data), headers: {
      'content-type': 'application/json',
      "Authorization": "Bearer ${preferences.getString("token")}",
    });
    if (response.statusCode == 200) {
      result = response.body;
    } else {
      DialogUtils.showOneBtn(context, jsonDecode(response.body)['message'],true);
    }
    return result;
  }

  ///get api
  static Future<String> apiGetRequestae(String url) async {
    String result = "";
    http.Response response = await http.get(Uri.parse(url), headers: {
      'content-type': 'application/json',
      // 'X-Api-Key': Settings.apiKey,
    });

    if (response.statusCode == 200) {
      result = response.body;
    } else {}
    return result;
  }

  ///spired token api
  static Future<String> apiGetRequestaeToken(String url) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String result = "";
    http.Response response = await http.get(Uri.parse(url), headers: {
      'content-type': 'application/json',
      "Authorization": "Bearer ${preferences.getString("token")}",
      // 'X-Api-Key': Settings.apiKey,
    });

    if (response.statusCode == 200) {
      result = response.body;
    } else {}
    return result;
  }

  // Cash Free Payment

  static Future<String> paymentPostRequest(String url, body) async {
    try {
      var response = await http.post(Uri.parse(url),
          headers: {
            "x-client-id": "144799ad8eef160dec12af5568997441",
            "x-client-secret": "13f31ba1da4c1cd96c7cbe4702851d0153bd7cf1"
          },
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        //var body = jsonDecode(response.body);
        // List<Post> posts = [];
        // body.forEach((e) {
        //   Post post = Post.fromJson(e);
        //   posts.add(post);
        // });

        return response.body;
      } else {
        return '';
      }
    } on SocketException {
      return '';
    } on FormatException {
      return '';
    } catch (e) {
      return '';
    }
  }
}
