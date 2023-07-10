// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

class SearchState {
  final List <StudentModel> student;
  SearchState({
    required this.student,
  });
}

class SearchInitial extends SearchState {
  SearchInitial({required super.student});
}


