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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create new Iry"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
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
                          onPressed: () {},
                          child: const Text("Search"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
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
    );
  }
}
