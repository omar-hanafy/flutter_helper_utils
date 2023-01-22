import 'dart:convert' as convert;
import 'dart:developer';

import 'package:http/http.dart' as http;

import './string_ext.dart';

const _defaultHeaders = {'Content-type': 'application/json'};

extension HttpExtensions on String {
  /// Sends an HTTP GET request with the given headers to the given URL, which can
  /// be a [Uri] or a [String].
  /// [endPoint] - end point of current url
  /// example:
  /// current string is www.domain.com
  /// endpoint param - user
  /// result request -> www.domain.com/user
  Future<dynamic> httpGet(String endPoint) async {
    if (isEmptyOrNull) return;

    try {
      final response = await http.get(Uri.http(this, endPoint));
      return response.statusCode == 200
          ? convert.jsonDecode(response.body)
          : log('Request failed with status: ${response.statusCode}.');
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  /// Sends an HTTP POST request with the given headers and body to the given URL,
  /// which can be a [Uri] or a [String].
  /// [endPoint] - end point of current url
  /// example:
  /// current string is www.domain.com
  /// endpoint param - user
  /// result request -> www.domain.com/user
  Future<dynamic> httpPost(String endPoint, String json,
      [Map<String, String> headers = _defaultHeaders]) async {
    if (isEmptyOrNull) return;

    try {
      final response = await http.post(Uri.http(this, endPoint),
          headers: headers, body: json);
      return response.statusCode == 200
          ? convert.jsonDecode(response.body)
          : log('Request failed with status: ${response.statusCode}.');
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  /// Sends an HTTP PUT request with the given headers and body to the given URL,
  /// which can be a [Uri] or a [String].
  /// [endPoint] - end point of current url
  /// example:
  /// current string is www.domain.com
  /// endpoint param - user
  /// result request -> www.domain.com/user
  Future<dynamic> httpPut(String endPoint, String json,
      [Map<String, String> headers = _defaultHeaders]) async {
    if (isEmptyOrNull) return;

    try {
      final response = await http.put(Uri.http(this, endPoint),
          headers: headers, body: json);
      return response.statusCode == 200
          ? convert.jsonDecode(response.body)
          : log('Request failed with status: ${response.statusCode}.');
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  /// Sends an HTTP DELETE request with the given headers to the given URL, which
  /// can be a [Uri] or a [String].
  /// [endPoint] - end point of current url
  /// example:
  /// current string is www.domain.com
  /// endpoint param - user
  /// result request -> www.domain.com/user
  Future<dynamic> httpDelete(String endPoint,
      {Map<String, String>? headers}) async {
    if (isEmptyOrNull) return;

    try {
      final response =
          await http.delete(Uri.http(this, endPoint), headers: headers);
      return response.statusCode == 200
          ? convert.jsonDecode(response.body)
          : log('Request failed with status: ${response.statusCode}.');
    } on Exception catch (e) {
      return Future.error(e);
    }
  }
}
