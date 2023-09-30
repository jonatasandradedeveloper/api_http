import 'package:api_http/model/post_model.dart';
import 'package:flutter/material.dart';

import '../controllers/post_controllers.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PostControllers _controller = PostControllers();

  @override
  void initState() {
    _controller.callApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api HTTP"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedBuilder(
                animation: Listenable.merge([
                  _controller.posts,
                  _controller.loading,
                ]),
                builder: (_, __) => _controller.loading.value
                    ? const CircularProgressIndicator()
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _controller.posts.value.length,
                        itemBuilder: (_, index) => ListTile(
                          title: Text(_controller.posts.value[index].title),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
