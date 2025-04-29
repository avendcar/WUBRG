import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_application_3/widgets/app_bar.dart';
import 'package:flutter_application_3/widgets/app_drawer.dart';

class PersonalEvent {
  final String id; // Firestore document ID
  final String name;
  final TimeOfDay time;
  final String location;

  PersonalEvent({
    required this.id,
    required this.name,
    required this.time,
    required this.location,
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'hour': time.hour,
        'minute': time.minute,
        'location': location,
        'date': '', // will be overridden on save
      };

  factory PersonalEvent.fromMap(Map<String, dynamic> map, String id) {
    return PersonalEvent(
      id: id,
      name: map['name'],
      location: map['location'],
      time: TimeOfDay(hour: map['hour'], minute: map['minute']),
    );
  }
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDayMain = DateTime.now();
  DateTime _focusedDayPersonal = DateTime.now();
  DateTime? _selectedDayMain;
  DateTime? _selectedDayPersonal;

  final Map<DateTime, List<String>> _mainEvents = {
    DateTime.utc(2025, 4, 22): ['FNM - Modern @ XYZ Games'],
    DateTime.utc(2025, 4, 24): ['Commander Night @ Dragon’s Lair'],
    DateTime.utc(2025, 4, 27): ['Draft - Outlaws of Thunder Junction'],
  };

  final Map<DateTime, List<PersonalEvent>> _personalEvents = {};

  DateTime _normalizeDate(DateTime date) => DateTime(date.year, date.month, date.day);

  @override
  void initState() {
    super.initState();
    _loadUserEvents();
  }

  Future<void> _loadUserEvents() async {
    final uid = auth.FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('calendarEvents')
        .get();

    final loadedEvents = <DateTime, List<PersonalEvent>>{};

    for (var doc in snapshot.docs) {
      final data = doc.data();
      final eventDate = DateTime.parse(data['date']);
      final event = PersonalEvent.fromMap(data, doc.id);

      if (!loadedEvents.containsKey(eventDate)) {
        loadedEvents[eventDate] = [];
      }
      loadedEvents[eventDate]!.add(event);
    }

    setState(() {
      _personalEvents.addAll(loadedEvents);
    });
  }

  Future<void> _saveEventToFirestore(DateTime date, PersonalEvent event) async {
    final uid = auth.FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final eventMap = event.toMap();
    eventMap['date'] = _normalizeDate(date).toIso8601String();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('calendarEvents')
        .add(eventMap);
  }

  Future<void> _deleteEventFromFirestore(String eventId) async {
    final uid = auth.FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('calendarEvents')
        .doc(eventId)
        .delete();
  }

  void _showAddEventDialog() {
    final nameController = TextEditingController();
    final locationController = TextEditingController();
    TimeOfDay selectedTime = TimeOfDay.now();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Personal Event"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: "Event name"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(hintText: "Location"),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                  );
                  if (picked != null) {
                    setState(() {
                      selectedTime = picked;
                    });
                  }
                },
                icon: const Icon(Icons.access_time),
                label: Text("Select Time: ${selectedTime.format(context)}"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              final name = nameController.text.trim();
              final location = locationController.text.trim();
              if (name.isNotEmpty && _selectedDayPersonal != null) {
                final date = _normalizeDate(_selectedDayPersonal!);
                final newEvent = PersonalEvent(
                  id: '', // will not use local ID
                  name: name,
                  time: selectedTime,
                  location: location,
                );

                setState(() {
                  _personalEvents.putIfAbsent(date, () => []).add(newEvent);
                });

                _saveEventToFirestore(date, newEvent);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added "$name" to ${date.month}/${date.day}/${date.year}'),
                    backgroundColor: Colors.deepPurpleAccent,
                  ),
                );

                Navigator.pop(context);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar({
    required DateTime focusedDay,
    required DateTime? selectedDay,
    required void Function(DateTime, DateTime) onDaySelected,
    required Map<DateTime, List> eventMap,
  }) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: focusedDay,
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      onDaySelected: onDaySelected,
      eventLoader: (day) => eventMap[_normalizeDate(day)] ?? [],
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(color: Colors.deepPurpleAccent, shape: BoxShape.circle),
        selectedDecoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        selectedTextStyle: TextStyle(color: Colors.black),
        defaultTextStyle: TextStyle(color: Colors.white),
        weekendTextStyle: TextStyle(color: Colors.grey),
      ),
      headerStyle: HeaderStyle(
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
        formatButtonTextStyle: const TextStyle(color: Colors.black),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(12),
        ),
        leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.white),
        rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.white),
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Colors.white),
        weekendStyle: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _buildEventList(List events, DateTime day, bool isPersonal) {
    if (events.isEmpty) {
      return const Text("No Events", style: TextStyle(color: Colors.white));
    }

    return Column(
      children: events
          .asMap()
          .entries
          .map(
            (entry) => isPersonal
                ? Card(
                    color: Colors.black54,
                    child: ListTile(
                      title: Text(entry.value.name, style: const TextStyle(color: Colors.white)),
                      subtitle: Text(
                        '${entry.value.location} • ${entry.value.time.format(context)}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () {
                          final event = entry.value;
                          setState(() {
                            _personalEvents[day]!.removeAt(entry.key);
                            if (_personalEvents[day]!.isEmpty) {
                              _personalEvents.remove(day);
                            }
                          });
                          _deleteEventFromFirestore(event.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Event deleted")),
                          );
                        },
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text("• ${entry.value}", style: const TextStyle(color: Colors.white)),
                  ),
          )
          .toList(),
    );
  }

  Widget _buildCalendarTab({
    required Widget calendar,
    required DateTime? selectedDay,
    required Map<DateTime, List> eventMap,
    required bool isPersonal,
  }) {
    final day = selectedDay != null ? _normalizeDate(selectedDay) : null;
    final events = day != null ? eventMap[day] ?? [] : [];

    return Column(
      children: [
        const SizedBox(height: 10),
        calendar,
        const SizedBox(height: 20),
        const Text("Events", style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 10),
        _buildEventList(events, day ?? DateTime.now(), isPersonal),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) {
          final currentIndex = DefaultTabController.of(context).index;

          return Scaffold(
            endDrawer: AppDrawer(),
            appBar: PersistentAppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(text: "Main Calendar"),
                  Tab(text: "Personal Calendar"),
                ],
              ),
            ),
            floatingActionButton: currentIndex == 1
                ? FloatingActionButton(
                    backgroundColor: Colors.deepPurpleAccent,
                    onPressed: _showAddEventDialog,
                    child: const Icon(Icons.add),
                  )
                : null,
            body: Container(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.02,
                horizontal: MediaQuery.of(context).size.width * 0.04,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.deepPurple, Colors.black],
                ),
              ),
              child: TabBarView(
                children: [
                  _buildCalendarTab(
                    calendar: _buildCalendar(
                      focusedDay: _focusedDayMain,
                      selectedDay: _selectedDayMain,
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDayMain = _normalizeDate(selectedDay);
                          _focusedDayMain = focusedDay;
                        });
                      },
                      eventMap: _mainEvents,
                    ),
                    selectedDay: _selectedDayMain,
                    eventMap: _mainEvents,
                    isPersonal: false,
                  ),
                  _buildCalendarTab(
                    calendar: _buildCalendar(
                      focusedDay: _focusedDayPersonal,
                      selectedDay: _selectedDayPersonal,
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDayPersonal = _normalizeDate(selectedDay);
                          _focusedDayPersonal = focusedDay;
                        });
                      },
                      eventMap: _personalEvents,
                    ),
                    selectedDay: _selectedDayPersonal,
                    eventMap: _personalEvents,
                    isPersonal: true,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
