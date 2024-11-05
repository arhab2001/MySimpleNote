import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/note.dart';
import 'note_edit_screen.dart';
import 'note_view_screen.dart';
import '../widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final loadedNotes = await DatabaseHelper().getNotes();
    setState(() {
      notes = loadedNotes;
    });
  }

  void _deleteNote(int id) async {
    await DatabaseHelper().delete(id);
    _loadNotes();
  }

  // Method to handle note editing
  Future<void> _editNote(Note note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteEditScreen(note: note)),
    );
    _loadNotes();
  }

  // Method to handle note viewing
  void _viewNote(Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteViewScreen(note: note)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Simple Note')),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return NoteCard(
            note: notes[index],
            onDelete: () => _deleteNote(notes[index].id!),
            onEdit: () => _editNote(notes[index]),
            onTap: () => _viewNote(notes[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NoteEditScreen()),
          );
          _loadNotes();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
