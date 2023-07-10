import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_student_bloc/bloc/update/update_bloc.dart';
import 'package:my_student_bloc/presentation/screenHome/screen_home.dart';
import 'bloc/image/image_bloc.dart';
import 'bloc/search/search_bloc.dart';
import 'infrastructure/models/studentModel.dart';


Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(const StudentRecord());
}

class StudentRecord extends StatelessWidget {
  const StudentRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UpdateBloc()),
        BlocProvider(create: (context) => ImageBloc()),
        BlocProvider(create: (context) => SearchBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        home: const HomeScreen(),
      ),
    );
  }
}
