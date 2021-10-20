import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import '../packages.dart';

class Auth with ChangeNotifier {
  static const String urlPrefix =
      'https://identitytoolkit.googleapis.com/v1/accounts:';
  static const String apiKey = '?key=';
  static const String apiValue = 'AIzaSyBQ5yAG-MLPOEFlIldObB8QfccSnMfyZfE';

  String? _token;
  String? _userId;
  DateTime? _expiryDate;

  bool get isAuth {
    return getToken != null;
  }

  String? get getToken {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(
      String? email, String? password, String segment) async {
    final url = Uri.parse(urlPrefix + segment + apiKey + apiValue);

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      var duration = int.parse(responseData['expiresIn']);
      _expiryDate = DateTime.now().add(Duration(seconds: duration));

      notifyListeners();
      log(json.decode(response.body).toString());
    } on HttpException catch (onError) {
      throw HttpException(onError);
    } catch (onError) {
      throw Exception(onError);
    }
  }

  Future<void> signup(String? email, String? password) async {
    const String segment = 'signUp';
    return _authenticate(email, password, segment);
  }

  Future<void> login(String? email, String? password) async {
    const String segment = 'signInWithPassword';
    return _authenticate(email, password, segment);
  }
}
