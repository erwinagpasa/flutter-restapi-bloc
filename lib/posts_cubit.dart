import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restapi_bloc/data_service.dart';
import 'package:restapi_bloc/post.dart';

class PostsCubit extends Cubit<List<Post>> {
  final _dataService = DataService();

  PostsCubit() : super([]);

  void getPosts() async => emit(await _dataService.getPosts());
}
