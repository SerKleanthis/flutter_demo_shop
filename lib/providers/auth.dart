import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:developer';
import '../packages.dart';

class Auth with ChangeNotifier {
  static const String urlPrefix =
      'https://identitytoolkit.googleapis.com/v1/accounts:';
  static const String apiKey = '?key=';
  static String apiValue = FlutterConfig.get('API_KEY');
  String? _token;
  String? _userId;
  DateTime? _expiryDate;
  bool autoLoggedIn = false;

  bool get isAuth {
    return getToken != null;
  }

  String? get getUserId {
    return _userId;
  }

  String? get getToken {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  bool get isAutoLoggedIn {
    return autoLoggedIn;
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('token') &&
        !prefs.containsKey('userId') &&
        !prefs.containsKey('expiryDate')) {
      // autoLoggedIn = false;
      return false;
    }

    _expiryDate = DateTime.parse(prefs.getString('expiryDate') ?? '');

    if (_expiryDate!.isBefore(DateTime.now())) {
      // autoLoggedIn = false;
      return false;
    }

    _token = prefs.getString('token');
    _userId = prefs.getString('userId');
    // autoLoggedIn = true;
    notifyListeners();
    return true;
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
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', _token!);
      prefs.setString('userId', _userId!);
      prefs.setString('expiryDate', _expiryDate!.toIso8601String());
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

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    notifyListeners();
  }
}
