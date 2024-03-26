part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetAllRequestsEvent extends HomeEvent {}

// ignore: must_be_immutable
class GetLiveRequestsEvent extends HomeEvent {
  String userId;
  GetLiveRequestsEvent({
    required this.userId,
  });
}
class GetDoneRequestsEvent extends HomeEvent {
  String userId;
  GetDoneRequestsEvent({
    required this.userId,
  });
}

class AcceptRequestEvent extends HomeEvent {
  String requestId;
  String deliveryId;
  String status;
  AcceptRequestEvent({
    required this.requestId,
    required this.deliveryId,
    required this.status,
  });
}
