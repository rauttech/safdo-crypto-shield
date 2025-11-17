/*
Project: Safdo Crypto Shield
Owner: Deepak Raghunath Raut
Disclaimer: This project is completely owned by Deepak Raghunath Raut.
By using, modifying, or redistributing this code you agree that ownership remains with Deepak Raghunath Raut.
License: MIT (see LICENSE file)
*/
import 'dart:async';
import 'dart:js_util' as js_util;

class PolkadotService {
  final String nodeUrl;
  PolkadotService({required this.nodeUrl});

  Future<Map<String, dynamic>> discoverInjectedWallets() async {
    try {
      final safdo = js_util.getProperty(js_util.globalThis, 'safdo');
      if (safdo == null) {
        return {'success': false, 'error': 'safdo bridge not found'};
      }
      final promise = js_util.callMethod(safdo, 'connectWallet', []);
      final result = await js_util.promiseToFuture(promise);
      return Map<String, dynamic>.from(result);
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> enableExtension(String source) async {
    try {
      final safdo = js_util.getProperty(js_util.globalThis, 'safdo');
      if (safdo == null) return {'success': false, 'error': 'bridge missing'};
      final promise = js_util.callMethod(safdo, 'enable', [source]);
      final result = await js_util.promiseToFuture(promise);
      return Map<String, dynamic>.from(result);
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> rpc(String method, [List<dynamic>? params]) async {
    try {
      final safdo = js_util.getProperty(js_util.globalThis, 'safdo');
      if (safdo == null) return {'success': false, 'error': 'bridge missing'};
      final promise = js_util.callMethod(safdo, 'rpc', [nodeUrl, method, params ?? []]);
      final result = await js_util.promiseToFuture(promise);
      return Map<String, dynamic>.from(result);
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }
}
