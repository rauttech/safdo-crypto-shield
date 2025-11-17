/*
Project: Safdo Crypto Shield
Owner: Deepak Raghunath Raut
Disclaimer: This project is completely owned by Deepak Raghunath Raut.
By using, modifying, or redistributing this code you agree that ownership remains with Deepak Raghunath Raut.
License: MIT (see LICENSE file)
*/
import 'package:http/http.dart' as http;
import 'dart:convert';

class RpcService {
  final String nodeUrl;
  RpcService({required this.nodeUrl});

  Future<dynamic> request(String method, [List<dynamic>? params]) async {
    final payload = jsonEncode({'jsonrpc':'2.0','id':1,'method':method,'params':params ?? []});
    final res = await http.post(Uri.parse(nodeUrl), body: payload, headers: {'Content-Type':'application/json'});
    if (res.statusCode == 200) {
      final j = jsonDecode(res.body);
      if (j['error'] != null) throw Exception(j['error']);
      return j['result'];
    } else {
      throw Exception('RPC error ${res.statusCode}:${res.body}');
    }
  }
}
