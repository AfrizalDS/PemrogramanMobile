import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kamera_flutter/widget/takepicture_screen.dart';

Future<void> main() async {
  // Pastikan plugin services diinisialisasi sebelum memanggil `availableCameras()`
  WidgetsFlutterBinding.ensureInitialized();

  // Dapatkan daftar kamera yang tersedia
  final cameras = await availableCameras();

  // Pilih kamera pertama dari daftar
  final firstCamera = cameras.first;

  // Jalankan aplikasi Flutter dan berikan kamera pertama sebagai parameter
  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        // Pass the appropriate camera to the TakePictureScreen widget.
        camera: firstCamera,
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
