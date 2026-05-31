import 'package:flutter/material.dart';

class BlogPage extends StatefulWidget {
  static const name = "/blog-screen";
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [Text("Welcome home")]));
  }
}
