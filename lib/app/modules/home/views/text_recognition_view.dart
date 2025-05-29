// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

// class TextRecognitionPage extends StatefulWidget {
//   @override
//   _TextRecognitionPageState createState() => _TextRecognitionPageState();
// }

// class _TextRecognitionPageState extends State<TextRecognitionPage> {
//   final ImagePicker _picker = ImagePicker();
//   late TextRecognizer _textRecognizer;
//   String _recognizedText = '';
//   String _matchedSerialNumber = '';
//   bool _serialNumberFound = false;

//   @override
//   void initState() {
//     super.initState();
//     _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
//   }

//   @override
//   void dispose() {
//     _textRecognizer.close();
//     super.dispose();
//   }

//   Future<void> _pickImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       final inputImage = InputImage.fromFilePath(image.path);
//       final RecognizedText recognizedText =
//           await _textRecognizer.processImage(inputImage);

//       // Sử dụng RegExp để kiểm tra từng dòng văn bản
//       final RegExp serialNumberPattern = RegExp(r'\d{11}-\d{2}');
//       bool found = false;
//       String matchedSerialNumber = '';
//       for (TextBlock block in recognizedText.blocks) {
//         for (TextLine line in block.lines) {
//           String trimmedLineText =
//               line.text.trim(); // Loại bỏ khoảng trắng ở đầu và cuối
//           print(
//               'Checking line: $trimmedLineText'); // In ra từng dòng để kiểm tra
//           if (serialNumberPattern.hasMatch(trimmedLineText)) {
//             found = true;
//             matchedSerialNumber = trimmedLineText; // Lưu chuỗi thỏa mãn
//             break;
//           }
//         }
//         if (found) break;
//       }

//       setState(() {
//         _recognizedText = recognizedText.text;
//         _serialNumberFound = found;
//         _matchedSerialNumber = matchedSerialNumber; // Cập nhật chuỗi thỏa mãn
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Text Recognition'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Capture Image'),
//             ),
//             SizedBox(height: 16),
//             Text(
//               _recognizedText,
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 16),
//             Text(
//               _serialNumberFound
//                   ? 'Serial number found: $_matchedSerialNumber'
//                   : 'Serial number not found',
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }