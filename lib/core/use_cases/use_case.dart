//Type -->datatype
//<> -->Generic
//[Param--> to determine the arguments you receive here]
import 'package:dartz/dartz.dart';

import '../errors/failure.dart';

abstract class UseCase<Type,Param>
{
  Future <Either<Failure,Type>>call([Param param]);
}
class NoParam{}