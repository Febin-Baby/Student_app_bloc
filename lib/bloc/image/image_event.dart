// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'image_bloc.dart';
@immutable
abstract class ImageEvent {}

class AddImage extends ImageEvent {
  String? imagePath;
  AddImage({
    required this.imagePath,
  });
}
