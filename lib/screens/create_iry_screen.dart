import 'dart:convert';
import 'dart:io';

import 'package:deairy/constants/app_constraints.dart';
import 'package:deairy/utils/file_util.dart';
import 'package:deairy/utils/snackbar_util.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CreateIryScreen extends StatefulWidget {
  const CreateIryScreen({super.key});

  @override
  State<CreateIryScreen> createState() => _CreateIryScreenState();
}

class _CreateIryScreenState extends State<CreateIryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nameController = TextEditingController();
  final _authorController = TextEditingController();
  final _passwordController = TextEditingController();
  final _filePathController = TextEditingController();
  var _showingPassword = false;

  String? validateTextInput(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a value";
    }

    return null;
  }

  void validateForm(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      final snackBar = SnackBarUtil.getSimpleSnackBar(
        "Please enter valid values",
        "Ok",
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
    }

    try {
      final file = File(_filePathController.text);
      if (file.existsSync()) {
        file.deleteSync();
        file.createSync();
        file.writeAsStringSync(jsonEncode({}));
      }
    } catch (err) {
      final snackBar = SnackBarUtil.getSimpleSnackBar(
        "Invalid path",
        "Ok",
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    submitForm();
  }

  void submitForm() async {
    final file = File(_filePathController.text);

    await file.create();
    await file.writeAsString(
      jsonEncode(
        {
          "name": _nameController.text,
          "author": _authorController.text,
          "password": _passwordController.text
        },
      ),
    );
  }

  void searchFilePath(BuildContext context) async {
    final fileName = FileUtil.sanitizeFilename(_nameController.text);

    final result = await FilePicker.platform.saveFile(
      dialogTitle: "Select a place to put the iry file",
      type: FileType.custom,
      allowedExtensions: ["iry"],
      fileName: _nameController.text.isNotEmpty ? "$fileName.iry" : "d.iry",
    );

    if (result == null) {
      return;
    }

    final filePath = result;
    _filePathController.text = filePath;
  }

  void togglePasswordVisibility() {
    setState(() {
      _showingPassword = !_showingPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Create new Iry"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            constraints: const BoxConstraints(
              maxWidth: AppConstraints.maxWidth,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    validator: validateTextInput,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Name"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _authorController,
                    validator: validateTextInput,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Author"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    validator: validateTextInput,
                    autocorrect: false,
                    enableSuggestions: false,
                    obscureText: !_showingPassword,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      label: const Text("Password"),
                      suffixIcon: IconButton(
                        onPressed: togglePasswordVisibility,
                        icon: Icon(
                          _showingPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _filePathController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Iry file path"),
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
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => validateForm(context),
                          child: const Text("Create"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
