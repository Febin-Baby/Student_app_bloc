// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'update_bloc.dart';
@immutable
abstract class UpdateEvent {}

// ignore: must_be_immutable
class UpdateImage extends UpdateEvent {
  String imagePath;
  UpdateImage({
    required this.imagePath,
  });
}
