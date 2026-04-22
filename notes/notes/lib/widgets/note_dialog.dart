import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes/models/note.dart';
import 'package:notes/services/note_service.dart';

class NoteDialog extends StatefulWidget {
  final Note? note;

  const NoteDialog({super.key, this.note});

  @override
  State<NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _imageFile;
}

@override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descriptionController.text = widget.note!.description;
      _base64Image = widget.note!.imageBase64;
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      );

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      String base64Image = base64Encode(bytes);
      setState(() {
        _base64Image = base64String;
        _imageFile = File(pickedFile.path);
      });
      print('Base64 Image: $base64Image');
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.note == null ? 'Add Notes' : 'Update Notes'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

        ],
      ), // Column
      actions: [

      ],
    ); // AlertDialog
  }

  const Text('Title: ', textAlign: TextAlign.start,), // Text
  TextField(
  controller: _titleController,), // TextField
  const Padding(
  padding: EdgeInsets.only(top: 20),
  child: Text('Description: ',), // Text
), // Padding
    TextField(controller: _descriptionController,maxLines: null,), 
    // TextField
  const Padding(
  padding: EdgeInsets.only(top: 20),
  child: Text('Image: '),
), // Padding
Expanded(
  child: _imageFile != null
      ? Image.file(_imageFile!, fit: BoxFit.cover)
      : (widget.note?.imageUrl != null &&
              Uri.parse(widget.note!.imageUrl!).isAbsolute
          ? Image.network(widget.note!.imageUrl!, fit: BoxFit.cover)
          : Container()), // Expanded
TextButton(
  onPressed: _pickImage,
  child: const Text('Pick Image'),
), // TextButton
const Padding(
  padding: EdgeInsets.only(top: 20),
  child: Text('Image: '),
), // Padding
Expanded(
  child: _imageFile != null
      ? Image.file(_imageFile!, fit: BoxFit.cover)
      : (widget.note?.imageUrl != null &&
              Uri.parse(widget.note!.imageUrl!).isAbsolute
          ? Image.network(widget.note!.imageUrl!, fit: BoxFit.cover)
          : Container()), // Expanded
TextButton(
  onPressed: _pickImage,
  child: const Text('Pick Image'),
), // TextButton