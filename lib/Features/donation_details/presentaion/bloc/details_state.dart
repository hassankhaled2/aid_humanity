part of 'details_bloc.dart';

sealed class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

final class DetailsInitial extends DetailsState {
  @override
  List<Object> get props => [];
}

class AddRequestSucccessState extends DetailsState {
  @override
  List<Object> get props => [];
}

class AddRequestErrorState extends DetailsState {
  final String message;

  const AddRequestErrorState({required this.message});
  @override
  List<Object> get props => [];
}

class AddRequestLoadingState extends DetailsState {
  @override
  List<Object> get props => [];
}

class UploadImagesSuccessState extends DetailsState {
  final List<String> imagesUrls;

  const UploadImagesSuccessState({required this.imagesUrls});
  @override
  List<Object> get props => [];
}

class UploadImagesErrorState extends DetailsState {
  @override
  List<Object> get props => [];
}

class UploadImagesLoadingState extends DetailsState {
  @override
  List<Object> get props => [];
}
