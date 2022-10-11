import 'package:flutter/material.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Provider/ads/cubit/ads_provider_cubit.dart';
import 'package:flutterglobal/Provider/blogs/cubit/blogs_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/View/BlogDetail/blog_detail_view.dart';
import 'package:flutterglobal/Widgets/Buttons/back_button.dart';

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
              decoration: Utils.instance.backgroundDecoration(
                  ImageEnums.background,
                  fit: BoxFit.fill),
              padding: EdgeInsets.only(top: 16),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        BackButtonWidget(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "En iyi 10",
                            style: context.textTheme.headlineSmall
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                      onTap: () async {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BlogDetailsView(
                                              blogModel: state.blogs[index],
                                            ),
                                          ),
                                        );

                                        context
                                            .read<AdsProviderCubit>()
                                            .state
                                            .adForTop10
                                            ?.show();

//yeni reklam için
                                        context
                                            .read<AdsProviderCubit>()
                                            .getTop10TransitionAd();
                                      },
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        height: 200,
                                        alignment: Alignment.bottomLeft,
                                        width: context.width,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              state.blogs[index].image
                                                  .toString(),
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Container(
                                            width: double.infinity,
                                            color: Colors.black.withOpacity(.4),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                state.blogs[index].title
                                                    .toString(),
                                                style: context
                                                    .textTheme.titleLarge
                                                    ?.copyWith(
                                                  color: Colors.white,
                                                  shadows: [
                                                    Shadow(
                                                      blurRadius: 10.0,
                                                      color: Colors.black,
                                                      offset: Offset(5.0, 5.0),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                          ],
                        ),
                      ),
                    ),
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
