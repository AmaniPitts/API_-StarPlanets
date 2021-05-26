import 'dart:io';

import 'package:api_stars_assignment/failure.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:api_stars_assignment/models.dart';




// https://swapi.dev/api/planets/
class StarPlanetsAPI {

  Future<Welcome> getStarWarsPlanets() async {
    var result;
    try {
      final call = await http.get(Uri.https('swapi.dev', 'api/planets/'));
      if (call.statusCode == 200) {
        final json = convert.jsonDecode(call.body);
        print(json);
        result = Welcome.fromJson(json);
      } else if (call.statusCode != 200) {
        throw Failure(message: "Check URL");
      }
    }
    on SocketException {
      throw Failure(message: "You're not connected to the internet Why ");
    } catch (error) {
      throw Failure(message: "AN unknown error occured");
    }
    return result;
  }
}