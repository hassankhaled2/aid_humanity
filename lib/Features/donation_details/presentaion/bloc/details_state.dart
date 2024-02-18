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



class AddRequestSucccessState extends DetailsState{
 @override
  List<Object> get props => [];
}
class AddRequestErrorState extends DetailsState{
   @override
  List<Object> get props => [];
}

class AddRequestLoadingState extends DetailsState{
   @override
  List<Object> get props => [];
}

