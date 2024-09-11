import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_app/bloc/todo/todo_cubit.dart';
import 'package:flutter_demo_app/models/todo_model.dart';
import 'package:flutter_demo_app/modules/main/widgets/bottom_loader.dart';
import 'package:flutter_demo_app/modules/main/widgets/todo_item.dart';

import 'helper/todo_filter.dart';
import 'modules/main/views/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}


