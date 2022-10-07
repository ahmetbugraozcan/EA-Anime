part of 'blogs_cubit.dart';

class BlogsState extends Equatable {
  final List<BlogModel> blogs;
  final bool isLoading;

  const BlogsState({
    this.blogs = const [],
    this.isLoading = false,
  });

  BlogsState copyWith({
    List<BlogModel>? blogs,
    bool? isLoading,
  }) {
    return BlogsState(
      blogs: blogs ?? this.blogs,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        blogs,
        isLoading,
      ];
}
