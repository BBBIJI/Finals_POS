import 'package:finalproject_pulse/common/helpr/navigator/app_navigator.dart';
import 'package:finalproject_pulse/common/widgets/custom_button.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:audioplayers/audioplayers.dart';

class BarcodeScannerPage extends StatefulWidget {
  final Function(String) onBarcodeScanned;
  final List<String> recognizedBarcodes;

  const BarcodeScannerPage({
    super.key,
    required this.onBarcodeScanned,
    required this.recognizedBarcodes,
  });

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isScanning = true;

  Future<void> _playSound() async {
    await _audioPlayer
        .play(AssetSource('assets/audio/barcode-scanner.mp3')); // Play audio
  }

  void _processBarcode(String barcode) async {
    if (!_isScanning) return;

    setState(() {
      _isScanning = false; // Pause scanning to process the result
    });

    final isRecognized = widget.recognizedBarcodes.contains(barcode);

    if (isRecognized) {
      _playSound(); // Play success sound
      widget.onBarcodeScanned(barcode); // Pass the result to parent
    } else {
      print('Unrecognized barcode: $barcode');
    }

    // Add a delay to avoid immediate rescan
    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() {
      _isScanning = true; // Resume scanning
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Adjust the scanner container size based on the screen size
    final containerWidth = screenWidth * 0.8; // 80% of screen width
    final containerHeight = screenHeight * 0.4; // 40% of screen height
    return Scaffold(
      backgroundColor: AppColors.greenlight,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: CustomButton(
              text: 'Done',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Center(
            child: Container(
              width: containerWidth,
              height: containerHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: MobileScanner(
                  onDetect: (BarcodeCapture capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    for (final barcode in barcodes) {
                      if (barcode.rawValue != null && _isScanning) {
                        _processBarcode(barcode.rawValue!);
                      }
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
