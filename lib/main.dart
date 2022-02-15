import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:to_do/modules/new_tasks/new_tasks_screen.dart';
import 'package:to_do/shared/bloc_observer.dart';
import 'package:to_do/shared/bloc_observer.dart';
import 'layout/home_layout.dart';

void main()
{
  Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}


// class MyApp

class MyApp extends StatelessWidget
{
  // constructor
  // build

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}