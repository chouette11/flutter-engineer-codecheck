import 'dart:convert';

import 'package:flutter_engineer_codecheck/home/home_state.dart';
import 'package:flutter_engineer_codecheck/models/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final homeViewModelProvider =
StateNotifierProvider.autoDispose<HomeViewModel, AsyncValue<HomeState>>(
      (ref) => HomeViewModel(ref: ref),
);

class HomeViewModel extends StateNotifier<AsyncValue<HomeState>> {
  final AutoDisposeStateNotifierProviderRef _ref;
  HomeViewModel({required AutoDisposeStateNotifierProviderRef ref})
      : _ref = ref,
        super(const AsyncLoading()) {
    load();
  }

  /// 通信、初期化処理
  Future<void> load() async {
    state = const AsyncValue.data(
      HomeState(
        searchWord: "",
        repositories: [],
      ),
    );
  }

  // textFieldとstateの対応
  void changeSearchWord(String value) {
    state = AsyncValue.data(state.value!.copyWith(searchWord: value));
  }

  Future<List<Repository>> fetchRepositories(String searchWord) async {
    final res = await http.get(Uri.parse('https://api.github.com/search/repositories?q=$searchWord&sort=stars&order=desc'));
    List<Repository> repositories = [];
    if (res.statusCode == 200) {
      final decoded = json.decode(res.body);
      for (var item in decoded['items']) {
        repositories.add(Repository.fromJson(item));
      }
      return repositories;
    } else {
      return repositories;
    }
  }

  Future<void> searchRepositories() async {
    final repositories = await fetchRepositories(state.value!.searchWord);
    state = AsyncValue.data(state.value!.copyWith(repositories: repositories));
  }

  // ロード制御
  Future<dynamic> whileLoading(Future future) {
    return Future.microtask(toLoading)
        .then<dynamic>((value) => future)
        .whenComplete(toIdle);
  }

  // ロード開始
  void toLoading() {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
  }

  // ロード終了
  void toIdle() {
    state = AsyncValue.data(state.value!.copyWith(isLoading: false));
  }
}
