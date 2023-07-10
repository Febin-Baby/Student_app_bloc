import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../Widgets/input_field_widget.dart';
import '../../bloc/image/image_bloc.dart';
import '../../infrastructure/functions/db_functions.dart';
import '../../infrastructure/models/studentModel.dart';

class InputPage extends StatelessWidget {
  InputPage({super.key});

  final formkey = GlobalKey<FormState>();

  String? _image;

  Future<void> pickImage(context) async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      BlocProvider.of<ImageBloc>(context).add(
        AddImage(imagePath: imagePicked.path),
      );
      // setState(() {
      //   _image = File(imagePicked.path);
      //   print(imagePicked.path);
      // });
    }
  }

  void clearPage() {
    _nameController.text = '';
    _ageController.text = '';
    _emailEditingController.text = '';
    _phoneEditingController.text = '';
  }

  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _phoneEditingController = TextEditingController();

  final _emailEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Student',
          style: GoogleFonts.aclonica(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formkey,
              child: ListView(
                children: [
                  BlocBuilder<ImageBloc, ImageState>(
                    builder: (context, state) {
                      _image = state.image;
                      return GestureDetector(
                        onTap: () => pickImage(context),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            CircleAvatar(
                              radius: 62,
                              backgroundColor: Colors.black54,
                              child: CircleAvatar(
                                radius: 70,
                                backgroundImage: _image == null
                                    ? const AssetImage(
                                            'assets/images/user02.jpg')
                                        as ImageProvider
                                    : FileImage(File(_image!)),
                              ),
                            ),
                            const Positioned(
                              bottom: 5.5,
                              child: Icon(
                                Icons.add_a_photo_rounded,
                                size: 25,
                                color: Color.fromARGB(255, 84, 92, 106),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InputFieldWidget(
                      inputController: _nameController,
                      label: 'Enter Your Name',
                      type: TextInputType.name),
                  InputFieldWidget(
                      inputController: _ageController,
                      label: 'Enter Your Age',
                      type: TextInputType.number),
                  InputFieldWidget(
                      inputController: _phoneEditingController,
                      label: 'Enter Your Phone',
                      type: TextInputType.phone),
                  InputFieldWidget(
                      inputController: _emailEditingController,
                      label: 'Enter Your e-mail',
                      type: TextInputType.emailAddress),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              formkey.currentState!.save();
                              StudentModel student = StudentModel(
                                age: _ageController.text,
                                name: _nameController.text,
                                phone: _phoneEditingController.text,
                                mail: _emailEditingController.text,
                                id: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                imgPath: _image ?? 'no-img',
                              );
                              addStudent(student);
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text(
                            'Register',
                            style: GoogleFonts.aclonica(),
                          ),
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
