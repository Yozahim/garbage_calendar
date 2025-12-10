import 'package:intl/intl.dart';

class DateParser {
  // Formatowanie daty dla wyświetlania
  String formatDate(DateTime date) {
    return DateFormat('EEEE, d MMMM yyyy', 'pl_PL').format(date);
  }

  // Parsowanie dat z tekstu OCR
  List<DateTime> parseDates(String text) {
    final List<DateTime> dates = [];
    final List<String> lines = text.split('\n');
    
    // Wzorce dat - różne formaty
    final List<RegExp> patterns = [
      // DD.MM.YYYY lub DD/MM/YYYY
      RegExp(r'\b(\d{1,2})[./](\d{1,2})[./](\d{4})\b'),
      // DD.MM.YY lub DD/MM/YY
      RegExp(r'\b(\d{1,2})[./](\d{1,2})[./](\d{2})\b'),
      // DD-MM-YYYY lub DD-MM-YY
      RegExp(r'\b(\d{1,2})-(\d{1,2})-(\d{4})\b'),
      RegExp(r'\b(\d{1,2})-(\d{1,2})-(\d{2})\b'),
      // YYYY-MM-DD
      RegExp(r'\b(\d{4})-(\d{1,2})-(\d{1,2})\b'),
      // DD MMMM YYYY (polskie nazwy miesięcy)
      RegExp(r'\b(\d{1,2})\s+(stycznia|lutego|marca|kwietnia|maja|czerwca|lipca|sierpnia|września|października|listopada|grudnia)\s+(\d{4})\b', caseSensitive: false),
    ];

    final Map<String, int> monthNames = {
      'stycznia': 1, 'lutego': 2, 'marca': 3, 'kwietnia': 4,
      'maja': 5, 'czerwca': 6, 'lipca': 7, 'sierpnia': 8,
      'września': 9, 'października': 10, 'listopada': 11, 'grudnia': 12
    };

    final DateTime now = DateTime.now();
    final int currentYear = now.year;

    for (String line in lines) {
      for (RegExp pattern in patterns) {
        final Iterable<RegExpMatch> matches = pattern.allMatches(line);
        
        for (RegExpMatch match in matches) {
          try {
            DateTime? date;
            
            if (match.groupCount == 3) {
              final String? part1 = match.group(1);
              final String? part2 = match.group(2);
              final String? part3 = match.group(3);
              
              if (part1 == null || part2 == null || part3 == null) continue;
              
              // Sprawdzenie czy to format z nazwą miesiąca
              if (monthNames.containsKey(part2.toLowerCase())) {
                final int day = int.parse(part1);
                final int month = monthNames[part2.toLowerCase()]!;
                final int year = int.parse(part3);
                date = DateTime(year, month, day);
              } else {
                // Format numeryczny
                int day, month, year;
                
                // Sprawdzenie czy pierwsza część to rok (YYYY-MM-DD)
                if (part1.length == 4) {
                  year = int.parse(part1);
                  month = int.parse(part2);
                  day = int.parse(part3);
                } else {
                  // DD.MM.YYYY lub DD.MM.YY
                  day = int.parse(part1);
                  month = int.parse(part2);
                  year = int.parse(part3);
                  
                  // Jeśli rok jest 2-cyfrowy, zakładamy że to 20XX
                  if (year < 100) {
                    year += 2000;
                  }
                }
                
                // Walidacja daty
                if (month >= 1 && month <= 12 && day >= 1 && day <= 31) {
                  date = DateTime(year, month, day);
                  
                  // Sprawdzenie czy data jest w przyszłości (lub niedalekiej przeszłości - max 1 miesiąc)
                  final DateTime oneMonthAgo = now.subtract(const Duration(days: 30));
                  if (date.isBefore(oneMonthAgo)) {
                    // Może to być data z przyszłego roku
                    date = DateTime(year + 1, month, day);
                  }
                }
              }
              
              if (date != null && !dates.contains(date)) {
                dates.add(date);
              }
            }
          } catch (e) {
            // Ignoruj błędy parsowania pojedynczych dat
            continue;
          }
        }
      }
    }
    
    // Sortowanie dat
    dates.sort();
    
    return dates;
  }
}

