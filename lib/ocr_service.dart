import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OcrService {
  final TextRecognizer _textRecognizer;

  OcrService() : _textRecognizer = TextRecognizer();

  Future<String> recognizeText(File imageFile) async {
    try {
      final InputImage inputImage = InputImage.fromFile(imageFile);
      final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);
      
      // Łączenie wszystkich linii tekstu
      final StringBuffer textBuffer = StringBuffer();
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          textBuffer.writeln(line.text);
        }
      }
      
      return textBuffer.toString();
    } catch (e) {
      throw Exception('Błąd OCR: $e');
    }
  }

  void dispose() {
    _textRecognizer.close();
  }
}

