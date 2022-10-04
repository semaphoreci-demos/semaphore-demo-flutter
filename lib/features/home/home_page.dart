// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semaphoreci_flutter_demo/features/detail/detail_page.dart';
import 'package:semaphoreci_flutter_demo/features/home/home_viewmodel.dart';

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late HomeViewModel homeViewModel;

  @override
  void didChangeDependencies() {
    homeViewModel = Provider.of<HomeViewModel>(
      context,
      listen: false,
    );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SemaphoreCI Flutter Demo',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const ValueKey('button.add'),
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute<DetailPage>(
              builder: (_) => const DetailPage(
                type: DetailPageType.add,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 12,
                right: 12,
                top: 32,
                bottom: 24,
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<HomeViewModel>(
                builder: (_, data, __) => ListView.builder(
                  itemCount: data.todos.length,
                  itemBuilder: (_, i) => ListTile(
                    title: Text(data.todos[i].title),
                    subtitle: Text(data.todos[i].description),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute<DetailPage>(
                          builder: (_) => DetailPage(
                            type: DetailPageType.edit,
                            item: data.todos[i],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
