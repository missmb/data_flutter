import 'dart:convert';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
import 'Food.dart';

class Services {
  static const ROOT = 'http://localhost/server/data_action.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_DATA_ACTION = 'ADD_DATA';
  static const _UPDATE_DATA_ACTION = 'UPDATE_DATA';
  static const _DELETE_DATA_ACTION = 'DELETE_DATA';

// Method to create the table Food
  static Future<String> createTable() async {
    try {
      // add the parameter to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(ROOT, body: map);
      print('Create Table Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "Error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<List<Food>> getFood() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(ROOT, body: map);
      print('GetFood Response: ${response.body}');
      if (200 == response.statusCode) {
        List<Food> list = parseResponse(response.body);
        return list;
      }
    } catch (e) {
      return List<Food>(); // return an empty list on exeption/error
    }
  }

  static List<Food> parseResponse(String responseaBody) {
    final parsed = json.decode(responseaBody).cast<Map<String, dynamic>>();
    return parsed.map<Food>((json) => Food.fromJSON(json)).toList();
  }

  static Future<String> addFood(String username, String food) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_DATA_ACTION;
      map['username'] = username;
      map['food'] = food;
      final response = await http.post(ROOT, body: map);
      print('addFood Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to update an Food in the Database...
  static Future<String> updateFood(int id, String username, String food) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_DATA_ACTION;
      map['id'] = id;
      map['username'] = username;
      map['food'] = food;
      final response = await http.post(ROOT, body: map);
      print('updateFood Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to update an Food in the Database...
  static Future<String> deleteFood(int id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_DATA_ACTION;
      map['id'] = id;
      final response = await http.post(ROOT, body: map);
      print('deleteFood Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
}
