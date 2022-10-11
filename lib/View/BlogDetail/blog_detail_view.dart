import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Models/blog_model.dart';
import 'package:flutterglobal/Widgets/Buttons/back_button.dart';

class BlogDetailsView extends StatelessWidget {
  final BlogModel blogModel;
  BlogDetailsView({super.key, required this.blogModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: Utils.instance.backgroundDecoration(ImageEnums.background),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButtonWidget(),
                Container(
                  color: Colors.black.withOpacity(.5),
                  child: Html(
                    data: blogModel.content.toString(),
                    style: {
                      "body": Style(
                        color: Colors.white,
                      ),
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
