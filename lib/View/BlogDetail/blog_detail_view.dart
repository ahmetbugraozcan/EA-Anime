import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutterglobal/Models/blog_model.dart';

class BlogDetailsView extends StatelessWidget {
  final BlogModel blogModel;
  BlogDetailsView({super.key, required this.blogModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Html(
                data: blogModel.content.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
