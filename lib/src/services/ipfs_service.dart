/*
Project: Safdo Crypto Shield
Owner: Deepak Raghunath Raut
Disclaimer: This project is completely owned by Deepak Raghunath Raut.
By using, modifying, or redistributing this code you agree that ownership remains with Deepak Raghunath Raut.
License: MIT (see LICENSE file)
*/
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class IpfsService {
  final String apiBase;
  final String token;
  IpfsService({required this.token, this.apiBase='https://api.web3.storage/upload'});

  Future<String> uploadBytes(Uint8List data) async {
    final res = await http.post(
      Uri.parse(apiBase),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/octet-stream'
      },
      body: data
    );
    if (res.statusCode == 200 || res.statusCode == 202) {
      final j = jsonDecode(res.body);
      return j['cid'].toString();
    } else {
      throw Exception('IPFS upload failed: ${res.statusCode} ${res.body}');
    }
  }
}
