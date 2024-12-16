import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_code_dart_scan/src/util/qr_code_dart_scan_resolution_preset.dart';

///
/// Created by
///
/// ─▄▀─▄▀
/// ──▀──▀
/// █▀▀▀▀▀█▄
/// █░░░░░█─█
/// ▀▄▄▄▄▄▀▀
///
/// Pankaj Ram
/// on 12/08/21
extension QrCodeDartScanResolutionPresetExtension
    on QRCodeDartScanResolutionPreset {
  ResolutionPreset toResolutionPreset() {
    switch (this) {
      case QRCodeDartScanResolutionPreset.low:
        return ResolutionPreset.low;
      case QRCodeDartScanResolutionPreset.medium:
        return ResolutionPreset.medium;
      case QRCodeDartScanResolutionPreset.high:
        return ResolutionPreset.high;
      case QRCodeDartScanResolutionPreset.veryHigh:
        return ResolutionPreset.veryHigh;
      case QRCodeDartScanResolutionPreset.ultraHigh:
        return ResolutionPreset.ultraHigh;
      case QRCodeDartScanResolutionPreset.max:
        return ResolutionPreset.max;
    }
  }
}

extension CameraImageExtension on CameraImage {
  Map toPlatformData() {
    return <dynamic, dynamic>{
      'height': height,
      'width': width,
      'format': _getFormat(),
      'planes': _getPlanes(),
    };
  }

  Map<String, dynamic> _getFormat() {
    return {
      'group': format.group,
      'raw': format.raw,
    };

    // if (defaultTargetPlatform == TargetPlatform.android) {
    //   switch (format.group) {
    //     // android.graphics.ImageFormat.YUV_420_888
    //     case ImageFormatGroup.yuv420:
    //       return 35;
    //     // android.graphics.ImageFormat.JPEG
    //     case ImageFormatGroup.jpeg:
    //       return 256;
    //     case ImageFormatGroup.unknown:
    //     case ImageFormatGroup.bgra8888:
    //   }
    // }

    // if (defaultTargetPlatform == TargetPlatform.iOS) {
    //   switch (format.group) {
    //     // kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange
    //     case ImageFormatGroup.yuv420:
    //       return 875704438;
    //     // kCVPixelFormatType_32BGRA
    //     case ImageFormatGroup.bgra8888:
    //       return 1111970369;
    //     case ImageFormatGroup.unknown:
    //       break;
    //     case ImageFormatGroup.jpeg:
    //       break;
    //   }
    // }
    // return 0;
  }

  List<Map<dynamic, dynamic>> _getPlanes() {
    return planes.map((e) {
      return <dynamic, dynamic>{
        'bytes': e.bytes,
        'bytesPerPixel': e.bytesPerPixel,
        'bytesPerRow': e.bytesPerRow,
        'height': e.height,
        'width': e.width,
      };
    }).toList();
  }
}

extension StateExt on State {
  void postFrame(VoidCallback execute) {
    Future.delayed(Duration.zero, () {
      if (mounted) {
        execute();
      }
    });
  }
}
