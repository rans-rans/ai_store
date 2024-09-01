import 'dart:convert';
import 'dart:io';

import 'package:ai_store/src/features/search/presentation/screens/image_search_result_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class OpenCameraScreen extends StatefulWidget {
  const OpenCameraScreen({super.key});

  @override
  State<OpenCameraScreen> createState() => _OpenCameraScreenState();
}

class _OpenCameraScreenState extends State<OpenCameraScreen> {
  late List<CameraDescription> cameras;

  late CameraController cameraController;

  Future<void> isCameraEnabled() async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.veryHigh,
      enableAudio: false,
    );
    await cameraController.initialize();
  }

  classifyImage(String path) async {
    try {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Container(
            alignment: Alignment.center,
            height: MediaQuery.sizeOf(context).height * 0.4,
            width: MediaQuery.sizeOf(context).width * 0.7,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                Text(
                  "Analyzing image for result",
                )
              ],
            ),
          ),
        ),
      );
      final imageFile = File(path);
      final imageBytes = await imageFile.readAsBytes();
      final imageEncoded = base64Encode(imageBytes);
      final aiResponse = await http.post(
        Uri.parse('https://ai-model-endpoint-8671ca0a35ab.herokuapp.com/predict'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'image_base64': imageEncoded,
        }),
      );
      final data = json.decode(aiResponse.body) as Map<String, dynamic>;
      final catID = data["predicted_index"] as int;
      if (!mounted) return;
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ImageSearchResultScreen(categoryId: catID)),
      );
    } catch (e) {
      Navigator.pop(context);
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    Permission.camera.request();
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Theme(
        data: ThemeData(
          iconButtonTheme: IconButtonThemeData(
            style: IconButton.styleFrom(
              foregroundColor: Colors.white,
            ),
          ),
        ),
        child: FutureBuilder(
            future: isCameraEnabled(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return Stack(
                children: [
                  CameraPreview(cameraController),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SafeArea(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.image),
                              onPressed: () async {
                                final picker = ImagePicker();
                                final pickedImage =
                                    await picker.pickImage(source: ImageSource.gallery);
                                if (pickedImage == null) return;
                                classifyImage(pickedImage.path);
                              },
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 5,
                              color: Colors.white,
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.circle,
                              size: 45,
                            ),
                            onPressed: () {
                              cameraController.takePicture().then((image) {
                                classifyImage(image.path);
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }
}
