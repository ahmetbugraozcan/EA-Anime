import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Models/blog_model.dart';
import 'package:flutterglobal/Service/firebase_firestore_service.dart';

part 'blogs_state.dart';

class BlogsCubit extends Cubit<BlogsState> {
  FirebaseFireStoreService _fireStoreService =
      FirebaseFireStoreService.instance;
  BlogsCubit() : super(BlogsState()) {
    getBlogs();
  }

  Future<void> getBlogs() async {
    emit(state.copyWith(isLoading: true));
    var data = await _fireStoreService.getBlogs();
    if (data != null) {
      emit(state.copyWith(blogs: data, isLoading: false));
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }

  void setBlogs(List<BlogModel> blogs) {
    emit(state.copyWith(blogs: blogs));
  }

  void setLoading(bool isLoading) {
    emit(state.copyWith(isLoading: isLoading));
  }
}
