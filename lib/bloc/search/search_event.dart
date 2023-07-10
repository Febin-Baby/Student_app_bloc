// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';


class SearchEvent {}

class OnSearch extends SearchEvent {
  final List<StudentModel> searchDetail;
  final String value;
  OnSearch({
    required this.searchDetail,
    required this.value,
  });
}
