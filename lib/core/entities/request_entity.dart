import 'package:equatable/equatable.dart';
class RequestEntity extends Equatable {

  final DateTime time;
  final Map<String, dynamic> address;
  final int numberOfItems;

  const RequestEntity({
    required this.time,
    required this.address,
    required this.numberOfItems,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}
