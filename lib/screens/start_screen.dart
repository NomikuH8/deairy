import 'package:deairy/controllers/file_controller.dart';
import 'package:deairy/screens/create_iry_screen.dart';
import 'package:deairy/utils/snackbar_util.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _pathFileOpen = TextEditingController(
    text: FileController.to.filePath.value,
  );

  void searchFilePath(BuildContext context) async {
    var result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: <String>["iry"],
      dialogTitle: "Select the diary file",
      lockParentWindow: true,
    );

    if (result == null) {
      var snackBar = SnackbarUtil.getSimpleSnackBar(
        'I need a file ".iry" to work!',
        "Ok",
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    var filePath = result.files.single.path!;
    FileController.to.setFilePath(filePath);
    _pathFileOpen.text = filePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            constraints: const BoxConstraints(
              minWidth: 100,
              maxWidth: 350,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Iry path"),
                    ),
                    readOnly: true,
                    controller: _pathFileOpen,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          OverflowBar(
            alignment: MainAxisAlignment.center,
            overflowAlignment: OverflowBarAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => searchFilePath(context),
                child: const Text("Search"),
              ),
              const SizedBox(
                width: 10,
                height: 10,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: const Text("Open"),
                iconAlignment: IconAlignment.end,
                onPressed: () {},
              ),
              const SizedBox(
                width: 10,
                height: 10,
              ),
              ElevatedButton(
                child: const Text("Create new Iry"),
                onPressed: () => Get.to(() => const CreateIryScreen()),
              )
            ],
          ),
        ],
      ),
    );
  }
}
