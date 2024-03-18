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

class GetLiveRequestsSuccess extends HomeState {
  final List<RequestEntity> requests;
  const GetLiveRequestsSuccess({required this.requests});
}

class GetLiveRequestsFailure extends HomeState {
  final String message;
  const GetLiveRequestsFailure({required this.message});
}

class GetLiveRequestsLoading extends HomeState {}

class AcceptRequsetSuccessState extends HomeState {}

class AcceptRequsetErrorState extends HomeState {}

class AcceptRequsetLoadingState extends HomeState {}
