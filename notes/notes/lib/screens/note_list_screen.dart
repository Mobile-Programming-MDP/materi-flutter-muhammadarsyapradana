import 'package:flutter/material.dart';
import 'package:notes/services/note_service.dart';
import 'package:notes/widgets/note_dialog.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: const NoteListScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const NoteDialog();
            },
          );
        },
        tooltip: 'Add Note ',
        child: const Icon(Icons.add),
        
        class NoteListScreen extends StatelessWidget {
        const NoteListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: NoteService.getNoteList(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            ); // Center
          default:
            return ListView(
              padding: const EdgeInsets.only(bottom: 80),
              children: snapshot.data!.map((document) {
                return Card(
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return NoteDialog(note: document);
                        },
                      );
                    },
                    child: Column(
                      children: [
                        document.imageUrl != null &&
                                Uri.parse(document.imageUrl!).isAbsolute
                            ? ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ), // BorderRadius.only
                                child: Image.network(
                                  document.imageUrl!,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  height: 150,
                                ), // Image.network
                              ) // ClipRRect
                            : Container(),
                        ListTile(
                          title: Text(document.title),
                          subtitle: Text(document.description),
                          trailing: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Konfirmasi Hapus'),
                                    content: Text(
                                        'Yakin ingin menghapus data \'${document.title}\' ?'), // Text
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          TextButton(
                                        child: const Text('Hapus'),
                                        onPressed: () {
                                          NoteService.deleteNote(document)
                                              .whenComplete(() =>
                                                  Navigator.of(context).pop());
                                        },
                                      ), // TextButton
                                    ], // <Widget>[]
                                  ); // AlertDialog
                                },
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Icon(Icons.delete),
                            ), // Padding
                          ), // InkWell
                        ), // ListTile
                      ],
                    ), // Column
                  ), // InkWell
                ); // Card
              }).toList(),
            ); // ListView
        }
      },
    ); // StreamBuilder
  }
}
      ), // FloatingActionButton
    ); // Scaffold
  }
}