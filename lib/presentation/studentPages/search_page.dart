import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../bloc/search/search_bloc.dart';
import '../../infrastructure/models/studentModel.dart';
import '../screenHome/screen_home.dart';
import '../studentDetails/detailed_view.dart';

class SearchPage extends StatelessWidget {
   SearchPage({super.key});

  List<StudentModel> studentList =
      Hive.box<StudentModel>('student_db').values.toList();

  late List<StudentModel> studentSearch = List<StudentModel>.from(studentList);

  TextEditingController searchCotntroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SearchBloc>(context)
        .add(OnSearch(searchDetail: studentList, value: ' '));
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(241, 243, 241, 241),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller: searchCotntroller,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      searchCotntroller.clear();
                    },
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onChanged: (value) {
                  BlocProvider.of<SearchBloc>(context)
                      .add(OnSearch(searchDetail: studentList, value: value));
                },
              ),
              const SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    return studentSearch.isNotEmpty
                        ? ListView.separated(
                          itemCount: state.student.length,
                            itemBuilder: (ctx, index) {
                              File? image;
                              StudentModel stu = studentSearch[index];
                              if (stu.imgPath != 'no-img') {
                                image = File(stu.imgPath!);
                              }
                              File imge = File(studentList[index].imgPath??'');
                             
                              
                              
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ctx) => DetaildView(
                                            name: state.student[index].name,
                                            age: state.student[index].age,
                                            phone: state.student[index].phone,
                                            email: state.student[index].mail,
                                            image:image,
                                          ),
                                        ),
                                      );
                                    },
                                    title: Text(state.student[index].name),
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.black12,
                                      child: ClipOval(
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(20),
                                          child: (image != null)
                                              ? Image.file(
                                                  imge,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  'assets/images/user02.jpg'),
                                        ),
                                      ),
                                    ),
                                    trailing: SizedBox(
                                      width: 150,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              bottomSheet(context, stu);
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              deleteAlert(context,
                                                  studentSearch[index]);
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Color.fromARGB(
                                                  255, 206, 107, 100),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            //},
                            separatorBuilder: (ctx, index) {
                              return SizedBox(
                                height: MediaQuery.of(context).size.height*.01,
                              );
                            },
                        )
                        : const Center(
                            child: Text(
                              'Could not searcresult',
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
