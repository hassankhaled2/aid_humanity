part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

class GetAllRequestsSuccess extends HomeState {
  final List<RequestEntity> requests;
  const GetAllRequestsSuccess({required this.requests});
}

class GetAllRequestsFailure extends HomeState {
  final String message;
  const GetAllRequestsFailure({required this.message});
}

class GetAllRequestsLoading extends HomeState {}

class GetLiveOrDoneRequestsSuccess extends HomeState {
  final List<RequestEntity> requests;
  const GetLiveOrDoneRequestsSuccess({required this.requests});
}

class GetLiveOrDoneRequestsFailure extends HomeState {
  final String message;
  const GetLiveOrDoneRequestsFailure({required this.message});
}

class GetLiveOrDoneRequestsLoading extends HomeState {}

class AcceptRequsetSuccessState extends HomeState {}

class AcceptRequsetErrorState extends HomeState {}

class AcceptRequsetLoadingState extends HomeState {}
