/*
Project: Safdo Crypto Shield
Owner: Deepak Raghunath Raut
Disclaimer: This project is completely owned by Deepak Raghunath Raut.
By using, modifying, or redistributing this code you agree that ownership remains with Deepak Raghunath Raut.
License: MIT (see LICENSE file)
*/
import 'package:flutter/material.dart';
import '../services/polkadot_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String status = 'Idle';
  final polka = PolkadotService(nodeUrl: const String.fromEnvironment('POLKADOT_NODE_URL', defaultValue: 'https://rpc.polkadot.io'));

  void discover() async {
    setState(() { status = 'Discovering...'; });
    final res = await polka.discoverInjectedWallets();
    setState(() { status = res.toString(); });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Safdo Crypto Shield'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Safdo Crypto Shield - Polkadot Web Hackathon MVP', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: discover, child: const Text('Discover Wallets')),
            const SizedBox(height: 12),
            Text(status),
          ],
        ),
      ),
    );
  }
}
