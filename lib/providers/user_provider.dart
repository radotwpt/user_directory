import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  List<User> users = [];
  bool isLoading = false;
  String errorMessage = '';

  Future<void> fetchUsers() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw TimeoutException(
              'Request timeout. Please check your connection and try again.',
            ),
          );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body) as List;
        users = jsonData.map((user) => User.fromJson(user)).toList();
        isLoading = false;
        notifyListeners();
      } else {
        throw Exception('Failed to load data. Server returned ${response.statusCode}');
      }
    } on TimeoutException catch (e) {
      errorMessage = e.message;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = 'Error: ${e.toString()}';
      isLoading = false;
      notifyListeners();
    }
  }
}

class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);

  @override
  String toString() => message;
}