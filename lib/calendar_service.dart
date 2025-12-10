import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:intl/intl.dart';

class CalendarService {
  Future<void> addEventsToCalendar(List<DateTime> dates) async {
    for (DateTime date in dates) {
      await _addEventToCalendar(date);
    }
  }

  Future<void> _addEventToCalendar(DateTime date) async {
    // Formatowanie daty dla tytułu
    final String formattedDate = DateFormat('d MMMM', 'pl_PL').format(date);
    
    final Event event = Event(
      title: 'Wywóz śmieci - $formattedDate',
      description: 'Przypomnienie o wywozie śmieci - przypomnienie ustawione na 1 dzień wcześniej',
      location: '',
      startDate: date,
      endDate: date.add(const Duration(hours: 1)),
      iosParams: const IOSParams(
        reminder: Duration(days: 1), // Przypomnienie 1 dzień wcześniej
      ),
      androidParams: const AndroidParams(
        emailInvites: [],
      ),
    );

    await Add2Calendar.addEvent2Cal(event);
  }
}

