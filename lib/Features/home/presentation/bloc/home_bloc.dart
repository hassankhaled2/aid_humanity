import 'package:aid_humanity/core/constants/strings/faliures_strings.dart';
import 'package:aid_humanity/core/error/faliures.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:aid_humanity/Features/home/domain/use_cases/get_all_requests_usecase.dart';
import 'package:aid_humanity/core/entities/request_entity.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllRequestsUseCase getAllRequestsUseCase;
  HomeBloc({required this.getAllRequestsUseCase}) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is GetAllRequestsEvent) {
        emit(GetAllRequestsLoading());

        final faliureOrRequests = await getAllRequestsUseCase();

        emit(_mapFaliureOrRequestToState(faliureOrRequests));
      }
    });
  }

  HomeState _mapFaliureOrRequestToState(Either<Faliure, List<RequestEntity>> faliureOrRequests) {
    return faliureOrRequests.fold((faliure) => GetAllRequestsFailure(message: _mapFaliureToMessage(faliure)), (requests) {
      return GetAllRequestsSuccess(requests: requests);
    });
  }

  String _mapFaliureToMessage(Faliure failure) {
    switch (failure.runtimeType) {
      // this to get the extended types while run time :)
      // ignore: type_literal_in_constant_pattern
      case ServerFaliure:
        return SERVER_FALIURE_MESSAGE;
      // ignore: type_literal_in_constant_pattern
      case OfflineFaliure:
        return OFFLINE_FALIURE_MESSAGE;
      // ignore: type_literal_in_constant_pattern
      case NoDataFaliure:
        return No_Data_FALIURE_MESSAGE;
      default:
        return UN_EXCPECTED_ERROR_MESSAGE;
    }
  }
}
