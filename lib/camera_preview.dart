// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';

// class CameraScreen extends StatefulWidget {
//   const CameraScreen({super.key});

//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//    CameraController? _cameraController;
//   late List<CameraDescription> _cameras;
//   bool _isFlashOn = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     _cameras = await availableCameras();
//     _cameraController = CameraController(
//       _cameras.first,
//       ResolutionPreset.high,
//     );

//     await _cameraController!.initialize();
//     setState(() {});
//   }

//   void _toggleFlash() async {
//     if (_isFlashOn) {
//       await _cameraController!.setFlashMode(FlashMode.off);
//     } else {
//       await _cameraController!.setFlashMode(FlashMode.torch);
//     }

//     setState(() {
//       _isFlashOn = !_isFlashOn;
//     });
//   }

//   @override
//   void dispose() {
//     _cameraController!.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Camera with Flashlight')),
//       body: _cameraController!.value.isInitialized
//           ? Stack(
//               children: [
//                 CameraPreview(_cameraController!),
//                 Positioned(
//                   bottom: 20,
//                   left: 20,
//                   child: ElevatedButton(
//                     onPressed: _toggleFlash,
//                     child: Text(_isFlashOn ? 'Turn Off Flash' : 'Turn On Flash'),
//                   ),
//                 ),
//               ],
//             )
//           : Center(child: CircularProgressIndicator()),
//     );
//   }
// }
