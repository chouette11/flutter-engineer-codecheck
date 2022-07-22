import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/home/home_view_model.dart';
import 'package:flutter_engineer_codecheck/home/sub_pages/repository_detail_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final state = ref.watch(homeViewModelProvider);
    final viewModel = ref.watch(homeViewModelProvider.notifier);
    return state.when(
      data: (data) {
        return Scaffold(
          appBar: AppBar(title: const Text("Flutter Engineer CodeCheck")),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  onChanged: viewModel.changeSearchWord,
                  onEditingComplete: () => viewModel.searchRepositories(context),
                  decoration: InputDecoration(
                    hintText: l10n!.searchHintText,
                  ),
                ),
                Expanded(
                  child: !data.isLoading ? // レポジトリ検索中かどうか
                  ListView(
                    children: data.repositories.map((repo) =>
                        ListTile(
                          title: Text(repo.name),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RepositoryDetailPage(repository: repo),
                            ),
                          ),
                        ),
                    ).toList(),
                  ) : const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
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
