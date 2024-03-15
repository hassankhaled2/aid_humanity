part of 'classificaiton_cubit.dart';

sealed class ClassificaitonState extends Equatable {
  const ClassificaitonState();

  @override
  List<Object> get props => [];
}

final class ClassificaitonInitial extends ClassificaitonState {}

final class ModelLoadedState extends ClassificaitonState {
  @override
  List<Object> get props => [];
}

final class ModelErrorState extends ClassificaitonState {
  @override
  List<Object> get props => [];
}

final class ModelLoadingState extends ClassificaitonState {
  @override
  List<Object> get props => [];
}

final class ClassificaitonLoadingState extends ClassificaitonState {
  @override
  List<Object> get props => [];
}

final class ClassificaitonSuccessState extends ClassificaitonState {
  final List<Map<String, dynamic>> result;
  final List<File> itemsImages;

  const ClassificaitonSuccessState({required this.itemsImages, required this.result});
  @override
  List<Object> get props => [];
}

final class ClassificaitonErrorState extends ClassificaitonState {
  @override
  List<Object> get props => [];
}

final class KnnClassificaitonsSuccessState extends ClassificaitonState {
  final List< Map<String, dynamic>> knnOutput;

  const KnnClassificaitonsSuccessState({required this.knnOutput});
  @override
  List<Object> get props => [];
}

final class KnnClassificaitonsErrorState extends ClassificaitonState {
  final String errorMessage;

  KnnClassificaitonsErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}


final class KnnClassificaitonsLoadingState extends ClassificaitonState {
  @override
  List<Object> get props => [];
}
