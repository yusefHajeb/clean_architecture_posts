import 'package:clean_architecture_posts/core/network/networkconective.dart';
import 'package:clean_architecture_posts/features/posts/data/data_sources/local_data_source.dart';
import 'package:clean_architecture_posts/features/posts/data/data_sources/remote_data_source.dart';
import 'package:clean_architecture_posts/features/posts/data/repositories/posts_repository_impl.dart';
import 'package:clean_architecture_posts/features/posts/domain/repositories/post_repositories.dart';
import 'package:clean_architecture_posts/features/posts/domain/usecases/add_posts.dart';
import 'package:clean_architecture_posts/features/posts/domain/usecases/delete_posts.dart';
import 'package:clean_architecture_posts/features/posts/domain/usecases/get_all_posts.dart';
import 'package:clean_architecture_posts/features/posts/domain/usecases/update_posts.dart';
import 'package:clean_architecture_posts/features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:clean_architecture_posts/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
//bloc
  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(() => AddUpdateDeletePostBloc(
      addPost: sl(), deletePost: sl(), updatePost: sl()));

//useCase
  sl.registerLazySingleton(() => GetAllPostsUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddPostUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(repository: sl()));

//RepositoryImp
  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

//Database

  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sharedPreferences: sl()));

  //core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));

//ext
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
