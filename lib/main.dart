import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'ocr_service.dart';
import 'calendar_service.dart';
import 'date_parser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalendarz Śmieci',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  bool _isProcessing = false;
  String? _errorMessage;
  List<DateTime>? _parsedDates;
  final ImagePicker _picker = ImagePicker();
  final OcrService _ocrService = OcrService();
  final CalendarService _calendarService = CalendarService();
  final DateParser _dateParser = DateParser();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _image = File(image.path);
          _errorMessage = null;
          _parsedDates = null;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Błąd podczas wybierania zdjęcia: $e';
      });
    }
  }

  Future<void> _processImage() async {
    if (_image == null) return;

    setState(() {
      _isProcessing = true;
      _errorMessage = null;
      _parsedDates = null;
    });

    try {
      // OCR - odczyt tekstu ze zdjęcia
      final String text = await _ocrService.recognizeText(_image!);
      
      if (text.isEmpty) {
        setState(() {
          _errorMessage = 'Nie udało się odczytać tekstu ze zdjęcia. Spróbuj z innym zdjęciem.';
          _isProcessing = false;
        });
        return;
      }

      // Parsowanie dat z tekstu
      final List<DateTime> dates = _dateParser.parseDates(text);
      
      if (dates.isEmpty) {
        setState(() {
          _errorMessage = 'Nie znaleziono dat w tekście. Upewnij się, że zdjęcie zawiera daty.';
          _isProcessing = false;
        });
        return;
      }

      setState(() {
        _parsedDates = dates;
        _isProcessing = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Błąd podczas przetwarzania: $e';
        _isProcessing = false;
      });
    }
  }

  Future<void> _addToCalendar() async {
    if (_parsedDates == null || _parsedDates!.isEmpty) return;

    try {
      await _calendarService.addEventsToCalendar(_parsedDates!);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Dodano ${_parsedDates!.length} wydarzeń do kalendarza!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Błąd podczas dodawania do kalendarza: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Kalendarz Śmieci'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Przycisk wyboru zdjęcia
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isProcessing ? null : () => _pickImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Zrób zdjęcie'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isProcessing ? null : () => _pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Wybierz z galerii'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Podgląd zdjęcia
            if (_image != null) ...[
              Container(
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    _image!,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Przycisk przetwarzania
              ElevatedButton(
                onPressed: _isProcessing ? null : _processImage,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isProcessing
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          SizedBox(width: 12),
                          Text('Przetwarzanie...'),
                        ],
                      )
                    : const Text('Przetwórz zdjęcie'),
              ),
            ],
            
            // Błąd
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red),
                ),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
            
            // Znalezione daty
            if (_parsedDates != null && _parsedDates!.isNotEmpty) ...[
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Znaleziono ${_parsedDates!.length} dat:',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ..._parsedDates!.map((date) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        '• ${_dateParser.formatDate(date)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // Przycisk dodania do kalendarza
              ElevatedButton(
                onPressed: _addToCalendar,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(width: 8),
                    Text(
                      'Dodaj do kalendarza',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

