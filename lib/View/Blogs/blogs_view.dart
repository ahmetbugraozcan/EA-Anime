import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Models/blog_model.dart';
import 'package:flutterglobal/Provider/blogs/cubit/blogs_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/View/BlogDetail/blog_detail_view.dart';

class BlogsView extends StatelessWidget {
  const BlogsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlogsCubit(),
      child: BlocBuilder<BlogsCubit, BlogsState>(
        builder: (context, state) {
          return Scaffold(
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Blogs",
                      style: context.textTheme.headline5,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    if (state.isLoading)
                      Center(
                        child: CircularProgressIndicator(),
                      )
                    else
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.blogs.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => BlogDetailsView(
                                          blogModel: state.blogs[index],
                                        )));
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        state.blogs[index].image.toString(),
                                        height: 200,
                                        width: context.width,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      state.blogs[index].title.toString(),
                                      style: context.textTheme.headline6,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(),
                              ),
                            );
                          })
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
