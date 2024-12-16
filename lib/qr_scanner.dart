import 'package:flutter/material.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';
import 'package:sample/qr_scanner_overlay.dart';

class PictureDecode extends StatefulWidget {
  final Function(String) onCapture;
  const PictureDecode({super.key, required this.onCapture});

  @override
  State<PictureDecode> createState() => _PictureDecodeState();
}

class _PictureDecodeState extends State<PictureDecode> {
  ValueNotifier<bool> isEnterCodeMenually = ValueNotifier(false);
  late QRCodeDartScanController _codeDartScanController;
  final _codeController = TextEditingController();
  final _codeNotifier = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    _codeDartScanController = QRCodeDartScanController();
    _codeController.addListener(() {
      _codeNotifier.value = _codeController.text;
    });
  }

  @override
  void dispose() {
    _codeDartScanController.dispose();
    _codeController.dispose();
    _codeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Scan Qr Code'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.flash_on),
            onPressed: () {
              _codeDartScanController.toggleFlash();
            },
          )
        ],
      ),
      bottomSheet: ValueListenableBuilder<bool>(
          valueListenable: isEnterCodeMenually,
          builder: (_, value, ___) {
            return Visibility(
              visible: value,
              child: IntrinsicHeight(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      spacing: 30,
                      children: [
                        TextFormField(
                          controller: _codeController,
                          decoration: InputDecoration(
                            hintText: 'Enter Code',
                            labelText: 'Qr code',
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: _codeNotifier,
                          builder: (context, value, child) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                minimumSize: Size(double.maxFinite, 50),
                              ),
                              onPressed: () {
                                if (value.isNotEmpty) {
                                  Navigator.pop(context);
                                  widget.onCapture(value);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Please enter code'),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'Confirm',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
      body: Column(
        children: [
          Expanded(
            child: QRCodeDartScanView(
              controller: _codeDartScanController,
              scanInvertedQRCode: true,
              typeScan: TypeScan.live,
              resolutionPreset: QRCodeDartScanResolutionPreset.max,
              onCapture: (Result result) {
                widget.onCapture(result.text);
                Navigator.pop(context);
              },
              child: QRScannerOverlay(),
            ),
          ),
          TextButton(
            onPressed: () {
              isEnterCodeMenually.value = true;
            },
            child: Text('Enter Code Manually'),
          ),
        ],
      ),
    );
  }
}
