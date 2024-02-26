import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tflite_v2/tflite_v2.dart';

part 'classificaiton_state.dart';

class ClassificaitonCubit extends Cubit<ClassificaitonState> {
  ClassificaitonCubit() : super(ClassificaitonInitial());

  List<Map<String, dynamic>> results = [];
  Classification(List<File> images) async {
    emit(ClassificaitonLoadingState());
    try {
      await loadModel("assets/ai_model/Master_CNN.tflite", "assets/ai_model/master_lables.txt");
      await classifyImage(images, "Master");
      await loadModel("assets/ai_model/New_CNN.tflite", "assets/ai_model/lables.txt");
      await classifyImage(images, "Type");
      await loadModel("assets/ai_model/Gender_CNN.tflite", "assets/ai_model/Gender_classes.txt");
      await classifyImage(images, "Gender");
      emit(ClassificaitonSuccessState(result: results, itemsImages: images));
      results = [];
    } catch (e) {
      emit(ClassificaitonErrorState());
    }
  }

  Future<void> loadModel(String model, String labels) async {
    emit(ModelLoadingState());
    try {
      await Tflite.loadModel(
        model: model,
        labels: labels,
      );
      emit(ModelLoadedState());
    } catch (error) {
      emit(ModelErrorState());
    }
  }

  Future<void> classifyImage(List<File> images, String type) async {
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
        outputs.add(output[0]);
      }

      _mapModelOutputsToLabels(outputs, type);
    } catch (error) {
      emit(ClassificaitonErrorState());
    }
  }

  _mapModelOutputsToLabels(List<dynamic> outputs, String type) {
    for (int i = 0; i < outputs.length; i++) {
      if (type == "Master") {
        results.add({"Master": outputs[i]["label"]});
      } else if (type == "Type") {
        results[i][type] = outputs[i]["label"];
      } else if (type == "Gender") {
        results[i][type] = outputs[i]["label"];
      }
    }
  }

  Map<String, dynamic> knnOutput = {};
  knnClassification(String description) {
    print(description);
    emit(KnnClassificaitonsLoadingState());
    final dio = Dio();
    dio.post("http://10.0.2.2:5000/get_data", data: {"data": description}).then((value) {
      print(value.data);
      results.add(value.data);
      emit(KnnClassificaitonsSuccessState(knnOutput: results));
    }).catchError((error) {
      emit(KnnClassificaitonsErrorState());
      print(error);
    });
  }
}
