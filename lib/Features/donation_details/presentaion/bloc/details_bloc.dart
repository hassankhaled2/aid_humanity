import 'package:aid_humanity/core/entities/item_entity.dart';
import 'package:aid_humanity/core/entities/request_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:aid_humanity/Features/donation_details/domain/use_cases/add_request_use_case.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  AddRequestUSeCase addRequestUSeCase;
  DetailsBloc(
    this.addRequestUSeCase,
  ) : super(DetailsInitial()) {
    on<DetailsEvent>((event, emit) {

    });
  }
}
