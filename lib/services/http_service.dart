import 'dart:convert';

import 'package:mohamed_mounir_assesment/models/api_model.dart';
import 'package:http/http.dart' as http;

class HttpService {
  Future<ApiResponse> fetchData({required String url}) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final links = _parseLinks(response.headers['link'].toString());
      return ApiResponse(data: data, links: links);
    } else {
      throw Exception(
          'Failed to fetch data. Status code: ${response.statusCode}');
    }
  }

  Map<String, String> _parseLinks(String input) {
    final out = <String, String>{};
    final parts = input.split(', ');
    for (final part in parts) {
      if (part[0] != '<') {
        throw const FormatException('Invalid Link Header');
      }
      final kv = part.split('; ');
      var url = kv[0].substring(1);
      url = url.substring(0, url.length - 1);
      var key = kv[1];
      key = key.replaceAll('"', '').substring(4);
      out[key] = url;
    }
    return out;
  }
}
