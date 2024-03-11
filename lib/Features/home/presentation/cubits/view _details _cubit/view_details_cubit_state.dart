part of 'view_details_cubit_cubit.dart';

sealed class ViewDetailsCubitState extends Equatable {
  const ViewDetailsCubitState();

  @override
  List<Object> get props => [];
}

final class ViewDetailsCubitInitial extends ViewDetailsCubitState {}

final class ViewDetailsCubitLoading extends ViewDetailsCubitState {}

final class ViewDetailsCubitSuccess extends ViewDetailsCubitState {
  final Position position;

  ViewDetailsCubitSuccess({required this.position});
}

final class ViewDetailsCubitFaliure extends ViewDetailsCubitState {}
