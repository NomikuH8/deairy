import 'package:deairy/constants/app_constraints.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CreateIryScreen extends StatefulWidget {
  const CreateIryScreen({super.key});

  @override
  State<CreateIryScreen> createState() => _CreateIryScreenState();
}

class _CreateIryScreenState extends State<CreateIryScreen> {
  final _nameField = TextEditingController();
  final _authorField = TextEditingController();
  final _passwordField = TextEditingController();
  final _pathField = TextEditingController();

  void searchFilePath(BuildContext context) async {
    var result = await FilePicker.platform.saveFile(
      dialogTitle: "Select a place to put the iry file",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create new Iry"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: AppConstraints.maxWidth,
                ),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameField,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Name"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _authorField,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Author"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _passwordField,
                      autocorrect: false,
                      enableSuggestions: false,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Password"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _pathField,
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Path"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () => searchFilePath(context),
                          child: const Text("Search"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              constraints: const BoxConstraints(
                maxWidth: AppConstraints.maxWidth,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Create"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
