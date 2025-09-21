
import '../database/notes_database.dart';

import 'package:flutter/material.dart';


class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {

  List<Map<String, dynamic>> notes = [];
  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    final fetchedNotes = await NotesDatabase.instance.getNotes();

    setState(() {
      notes = fetchedNotes;
    });

  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: const Text('Notes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
      
          ),
          ),
            centerTitle: true,
            actions: [
              IconButton(
                style:ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blue),
                ),
                icon: const Icon(Icons.add),
                onPressed: () {
      
                },
      
              ),
            ],
      
        ),
        body: notes.isEmpty ? const Center(child: Text('No Notes'))
        : Padding(padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
        ),
          itemBuilder: (context, index) {
            final note = notes[index];
            return Text(note['title']);
          },
        ),

      ),
    );
  }
}
