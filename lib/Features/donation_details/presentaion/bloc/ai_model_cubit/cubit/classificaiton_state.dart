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
  final List<String> result;
  final List<File> itemsImages;

  const ClassificaitonSuccessState({required this.itemsImages, required this.result});
  @override
  List<Object> get props => [];
}

final class ClassificaitonErrorState extends ClassificaitonState {
  @override
  List<Object> get props => [];
}