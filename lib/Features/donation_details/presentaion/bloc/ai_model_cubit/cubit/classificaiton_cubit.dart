import 'dart:io';

import 'package:dartz/dartz_unsafe.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tflite_v2/tflite_v2.dart';

part 'classificaiton_state.dart';

class ClassificaitonCubit extends Cubit<ClassificaitonState> {
  ClassificaitonCubit() : super(ClassificaitonInitial());

  Future<void> loadModel() async {
    emit(ModelLoadingState());
    try {
      await Tflite.loadModel(
        model: "assets/ai_model/New_CNN.tflite",
        labels: "assets/ai_model/lables.txt",
      );
      emit(ModelLoadedState());
    } catch (error) {
      emit(ModelErrorState());
    }
  }

  Future<void> classifyImage(List<File> images) async {
    emit(ClassificaitonLoadingState());
    // ignore: prefer_typing_uninitialized_variables
    await Future.delayed(const Duration(seconds: 2));
    // ignore: prefer_typing_uninitialized_variables
    var output;
    var outputs = [];
    try {
      for (int i = 0; i < images.length; i++) {
        output = await Tflite.runModelOnImage(
          numResults: 2,
          path: images[i].path,
        );
        outputs.add(output);
      }
      List<String> result = _mapModelOutputsToLabels(outputs);
      emit(ClassificaitonSuccessState(result: result, itemsImages: images));
    } catch (error) {
      emit(ClassificaitonErrorState());
    }

    
  }

  List<String> _mapModelOutputsToLabels(List<dynamic> outputs) {
    List<String> result = [];
    for (int i = 0; i < outputs.length; i++) {
      result.add(outputs[i][0]['label']);
    }
    result = result.map((item) {
      // Split each item by space
      List<String> parts = item.split(' ');
      // Join all parts except the first one (the number)
      return parts.skip(1).join(' ');
    }).toList();

    return result;
  }
}
