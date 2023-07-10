import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../bloc/update/update_bloc.dart';
import '../infrastructure/functions/db_functions.dart';
import '../infrastructure/models/studentModel.dart';
import 'input_field_widget.dart';

// ignore: must_be_immutable
class InputBottonSheet extends StatefulWidget {
  StudentModel student;
  InputBottonSheet({super.key, required this.student});

  @override
  State<InputBottonSheet> createState() =>
      // ignore: no_logic_in_create_state
      _InputBottonSheetState(student: student);
}

class _InputBottonSheetState extends State<InputBottonSheet> {
  String? _image;

  Future<void> pickImage(context) async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      var tempPath = imagePicked.path;
      BlocProvider.of<UpdateBloc>(context)
          .add(UpdateImage(imagePath: tempPath));
      // setState(
      //   () {
      //     _image = File(imagePicked.path);
      //   },
      // );
    }
  }

  StudentModel student;

  _InputBottonSheetState({required this.student});
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();

  final TextEditingController _phoneEditingController = TextEditingController();

  final TextEditingController _emailEditingController = TextEditingController();

//initState sets the initial values to the input_field_widget
  @override
  void initState() {
    _nameController.text = student.name;
    _ageController.text = student.age;
    _phoneEditingController.text = student.phone;
    _emailEditingController.text = student.mail;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(
            height: 6,
          ),
          InputFieldWidget(
            inputController: _nameController,
            label: 'Name',
            type: TextInputType.name,
          ),
          const SizedBox(
            height: 6,
          ),
          InputFieldWidget(
            inputController: _ageController,
            label: 'Age',
            type: TextInputType.number,
          ),
          const SizedBox(
            height: 6,
          ),
          InputFieldWidget(
            inputController: _phoneEditingController,
            label: 'Phone Number',
            type: TextInputType.phone,
          ),
          const SizedBox(
            height: 6,
          ),
          InputFieldWidget(
            inputController: _emailEditingController,
            label: 'E-mail',
            type: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<UpdateBloc, UpdateState>(
                builder: (context, state) {
                  _image = state.image;
                  return InkWell(
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(Icons.image),
                        ),
                        Text(
                          'Change Photo',
                          style: GoogleFonts.aclonica(),
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: _image == null
                              ?  Image.asset('assets/images/user02.jpg')
                                  as ImageProvider
                              : FileImage(File(_image!)),
                        ),
                      ],
                    ),
                    onTap: () {
                      pickImage(context);
                    },
                  );
                },
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.blueGrey.shade300,
                    ),
                    onPressed: () {
                      StudentModel stu = StudentModel(
                        imgPath: _image ?? 'no-img',
                        id: student.id,
                        age: _ageController.text,
                        name: _nameController.text,
                        mail: _emailEditingController.text,
                        phone: _phoneEditingController.text,
                      );
                      updateStudent(stu);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Update Student',
                      style: GoogleFonts.aclonica(),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
