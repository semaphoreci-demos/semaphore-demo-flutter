import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semaphoreci_flutter_demo/features/detail/detail_viewmodel.dart';
import 'package:semaphoreci_flutter_demo/features/home/home_page.dart';
import 'package:semaphoreci_flutter_demo/features/home/home_viewmodel.dart';
import 'package:semaphoreci_flutter_demo/viewmodels/todo_viewmodel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  TodoViewModel todoViewModel = TodoViewModel();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => todoViewModel,
        ),
        ChangeNotifierProxyProvider<TodoViewModel, HomeViewModel>(
          create: (_) => HomeViewModel(
            todoViewModel: todoViewModel,
          ),
          update: (_, todo, __) => HomeViewModel(todoViewModel: todo),
        ),
        ChangeNotifierProxyProvider<TodoViewModel, DetailViewModel>(
          create: (_) => DetailViewModel(
            todoViewModel: todoViewModel,
          ),
          update: (_, todo, __) => DetailViewModel(todoViewModel: todo),
        ),
      ],
      child: MaterialApp(
        title: 'SemaphoreCI Flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
