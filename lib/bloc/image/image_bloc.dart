import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInital()) {
    on<AddImage>((event, emit) {
      return emit(ImageState(image: event.imagePath));
    });
  }
}
