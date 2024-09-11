import 'package:flutter/material.dart';
import 'package:flutter_demo_app/helper/todo_filter.dart';
import 'package:flutter_demo_app/modules/main/views/tab_todo_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  var filter = TodoFilter.all;

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo App'),
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        onTap: (index) {
          _tabController.animateTo(index);

          if (index == 0) {
            filter = TodoFilter.all;
          } else if (index == 1) {
            filter = TodoFilter.pending;
          } else if (index == 2) {
            filter = TodoFilter.draft;
          } else if (index == 3) {
            filter = TodoFilter.completed;
          }
        },
        tabs: const[
          Tab(icon: Icon(Icons.all_inclusive), text: 'All'),
          Tab(icon: Icon(Icons.pending), text: 'Pending'),
          Tab(icon: Icon(Icons.drafts), text: 'Draft'),
          Tab(icon: Icon(Icons.done), text: 'Completed'),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          TodoProvider(filter: TodoFilter.all),
          TodoProvider(filter: TodoFilter.pending),
          TodoProvider(filter: TodoFilter.draft),
          TodoProvider(filter: TodoFilter.completed),
        ],
      ),
    );
  }
}
