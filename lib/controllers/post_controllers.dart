import 'dart:convert';

import 'package:api_http/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostControllers {
  ValueNotifier<List<PostModel>> posts = ValueNotifier([]);
  ValueNotifier<bool> loading = ValueNotifier<bool>(false);

  callApi() async {
    var client = http.Client();
    try {
      loading.value = true;
      var response = await client.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );
      var decoded = jsonDecode(response.body) as List;
      posts.value = decoded.map((e) => PostModel.fromJson(e)).toList();
    } finally {
      client.close();
      loading.value = false;
    }
  }
}
