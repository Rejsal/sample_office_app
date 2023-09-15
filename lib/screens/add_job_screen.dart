import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_office_project/components/common_button.dart';
import 'package:sample_office_project/models/job_model.dart';
import 'package:sample_office_project/provider/job_provider.dart';
import 'package:sample_office_project/utils/constants.dart';
import 'package:sample_office_project/utils/helper.dart';
import 'package:sample_office_project/utils/styles.dart';

class AddJobScreen extends StatefulWidget {
  const AddJobScreen({required this.projectId, Key? key}) : super(key: key);

  final int projectId;

  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  final _titleController = TextEditingController(text: '');
  final _descriptionController = TextEditingController(text: '');
  final _noOfRequirementController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          addJob,
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
                        kTextFieldDecoration.copyWith(hintText: jobTitle),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _descriptionController,
                    validator: (value) =>
                        (value!.isEmpty) ? requiredField : null,
                    style: const TextStyle(color: Colors.white),
                    decoration:
                        kTextFieldDecoration.copyWith(hintText: description),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _noOfRequirementController,
                    validator: (value) =>
                        (value!.isEmpty) ? requiredField : null,
                    style: const TextStyle(color: Colors.white),
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: noOfRequirements),
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
                          await context.read<JobProvider>().addJob(JobModel(
                              projectId: widget.projectId,
                              title: _titleController.text,
                              description: _descriptionController.text,
                              numberOfRequirements: int.parse(
                                  _noOfRequirementController.text.trim()),
                              filledCount: 0));
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
