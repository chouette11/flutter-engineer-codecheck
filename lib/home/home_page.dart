import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/home/home_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);
    final viewModel = ref.watch(homeViewModelProvider.notifier);
    return state.when(
      data: (data) {
        return Scaffold(
          appBar: AppBar(title: const Text("test")),
          body: Column(
            children: [
              TextFormField(
                onChanged: viewModel.changeSearchWord,
              ),
              Expanded(
                child: ListView(
                  children: data.repositories.map((repo) =>
                      ListTile(title: Text(repo.name)),
                  ).toList(),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: viewModel.searchRepositories,
          ),
        );
      },
      error: (e, msg) => Text("$msg"),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
