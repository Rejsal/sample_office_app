import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_office_project/components/common_button.dart';
import 'package:sample_office_project/models/project_model.dart';
import 'package:sample_office_project/provider/project_provider.dart';
import 'package:sample_office_project/utils/constants.dart';
import 'package:sample_office_project/utils/helper.dart';
import 'package:sample_office_project/utils/styles.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({Key? key}) : super(key: key);

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  final _titleController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          addProject,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 550.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 50.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _titleController,
                    validator: (value) =>
                        (value!.isEmpty) ? titleRequired : null,
                    style: const TextStyle(color: Colors.white),
                    decoration:
                        kTextFieldDecoration.copyWith(hintText: projectTitle),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  CommonButton(
                    title: save,
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        try {
                          await context.read<ProjectProvider>().addProject(
                              ProjectModel(
                                  title: _titleController.text,
                                  name: _titleController.text
                                      .replaceAll(" ", '-')));
                          if (!mounted) return;
                          Navigator.pop(context);
                        } catch (e) {
                          if (!mounted) return;
                          await infoDialog(context, e.toString(), 'Ok');
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16.0,
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
