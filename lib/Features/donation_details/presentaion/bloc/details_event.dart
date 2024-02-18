part of 'details_bloc.dart';

sealed class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class AddRequestEvent extends DetailsEvent {
  RequestEntity requestEntity;
  List<ItemEntity> items;
  AddRequestEvent({
    required this.requestEntity,
    required this.items,
  });
}
