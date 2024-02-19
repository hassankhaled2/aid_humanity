import 'package:aid_humanity/Features/donation_details/data/remote_data_source.dart';
import 'package:aid_humanity/Features/donation_details/data/repositories_impl/details_repository_impl.dart';
import 'package:aid_humanity/Features/donation_details/domain/repository/details_repository.dart';
import 'package:aid_humanity/Features/donation_details/domain/use_cases/add_request_use_case.dart';
import 'package:aid_humanity/Features/donation_details/presentaion/bloc/details_bloc.dart';
import 'package:aid_humanity/core/network/networkconnection/network_connection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

GetIt getIt = GetIt.instance;

Future<void> init() async {
//! Features-details
// bloc
  getIt.registerFactory(() => DetailsBloc(getIt()));

//usecases

  getIt.registerLazySingleton(() => AddRequestUSeCase(detailsRepository: getIt()));
// repositories
  getIt.registerLazySingleton<DetailsRepository>(() => DetailsRepositoryImpl(detailsRemoteDataSource: getIt(), connctionInfo: getIt()));

  //dataSources
  getIt.registerLazySingleton<DetailsRemoteDataSource>(() => DetailsRemoteDataSourceImplWithFireBase(firestore: getIt()));

  // core
  getIt.registerLazySingleton<ConnctionInfo>(() => ConnectionInfoImpl(internetConnectionChecker: getIt()));

  //externel
  getIt.registerLazySingleton(() => InternetConnectionChecker());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  getIt.registerLazySingleton(() => firestore);
}
