// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'image_bloc.dart';
@immutable
class ImageState {
  final String? image;

  ImageState({
   required this.image,
  });
}

class ImageInital extends ImageState{
  ImageInital() :super(image: null);
}

