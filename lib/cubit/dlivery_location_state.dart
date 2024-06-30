part of 'dlivery_location_cubit.dart';

sealed class DliveryLocationState extends Equatable {
  const DliveryLocationState();

  @override
  List<Object> get props => [];
}

final class DliveryLocationInitial extends DliveryLocationState {}
final class GetLocationSuccessState extends DliveryLocationState {}

final class GetLocationFailedState extends DliveryLocationState {}

final class GetLocationLoadingState extends DliveryLocationState {}