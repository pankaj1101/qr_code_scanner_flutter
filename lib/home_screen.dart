import 'package:flutter/material.dart';
import 'package:sample/qr_scanner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String qrCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Scanned Code'),
            Text(qrCode),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return PictureDecode(
                  onCapture: (String code) {
                    if (code.isEmpty) {
                      qrCode = 'Scan Again';
                    } else {
                      qrCode = code;
                    }
                    setState(() {});
                  },
                );
              },
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.qr_code),
      ),
    );
  }
}
