// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'update_bloc.dart';

class UpdateState {
  final String? image;
  UpdateState({
   required this.image,
  });
}

class UpdateInitial extends UpdateState {
  UpdateInitial() :super(image: '');
}
