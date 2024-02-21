import 'dart:io';

import 'package:aid_humanity/core/entities/item_entity.dart';
import 'package:aid_humanity/core/entities/request_entity.dart';
import 'package:aid_humanity/core/error/faliures.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path/path.dart';

import 'package:aid_humanity/Features/donation_details/domain/use_cases/add_request_use_case.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  AddRequestUSeCase addRequestUSeCase;
  DetailsBloc(
    this.addRequestUSeCase,
  ) : super(DetailsInitial()) {
    on<DetailsEvent>((event, emit) async {
      if (event is UploadImagesEvent) {
        emit(UploadImagesLoadingState());
        if (await InternetConnectionChecker().hasConnection) {
          await _uploadRequestItemsImages(event.images);
        } else
          (emit(UploadImagesErrorState()));
      } else if (event is AddRequestEvent) {
        emit(AddRequestLoadingState());
        final falureOrUnit = await addRequestUSeCase.addRequest(event.requestEntity, event.items);
        emit(_mapFailureOrUnitToState(falureOrUnit));
      }
    });
  }

  DetailsState _mapFailureOrUnitToState(Either<Faliure, Unit> either) {
    return either.fold((failure) => AddRequestErrorState(message: _mapFaliureToMessage(failure)), (unit) => AddRequestSucccessState());
  }

  String _mapFaliureToMessage(Faliure failure) {
    switch (failure.runtimeType) {
      // this to get the extended types while run time :)
      // ignore: type_literal_in_constant_pattern
      case ServerFaliure:
        return "something went wrong";

      // ignore: type_literal_in_constant_pattern
      case OfflineFaliure:
        return "check your internet connection";

      default:
        return "unexpected error";
    }
  }

  Future<List<String>> _uploadRequestItemsImages(List<File> images) async {
    // ignore: invalid_use_of_visible_for_testing_member
    emit(UploadImagesLoadingState());
    List<String> imagesUrls = [];
    try {
      for (int i = 0; i < images.length; i++) {
        var imageName = basename(images[i].path);
        var refStorage = FirebaseStorage.instance.ref("requestsImages/$imageName");
        await refStorage.putFile(images[i]);
        var url = await refStorage.getDownloadURL();
        imagesUrls.add(url);
      }
      emit(UploadImagesSuccessState(imagesUrls: imagesUrls));
    } catch (e) {
      // ignore: invalid_use_of_visible_for_testing_member
      emit(UploadImagesErrorState());
    }
    return imagesUrls;
  }
}
