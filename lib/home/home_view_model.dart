import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/components/snackbar.dart';
import 'package:flutter_engineer_codecheck/home/home_state.dart';
import 'package:flutter_engineer_codecheck/models/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

  Future<List<Repository>> fetchRepositories(String searchWord, BuildContext context) async {
    final l10n = L10n.of(context);
    // エラーメッセージのダイアログを出す
    final snackBar = AppSnackBar.of(message: ScaffoldMessenger.of(context));
    final apiUrl = 'https://api.github.com/search/repositories?q=$searchWord&sort=stars&order=desc';
    final res = await whileLoading(http.get(Uri.parse(apiUrl)));
    List<Repository> repositories = [];
    if (res.statusCode == 200) {
      final decoded = json.decode(res.body);
      for (var item in decoded['items']) {
        repositories.add(Repository.fromJson(item));
      }
      return repositories;
    } else {
      String errorMessage = l10n!.errorMessage;
      switch (res.statusCode) {
        case 304:
          errorMessage = l10n.errorMessage304;
          break;
        case 403:
          errorMessage = l10n.errorMessage403;
          break;
        case 422:
          errorMessage = l10n.errorMessage422;
          break;
        case 502:
          errorMessage = l10n.errorMessage502;
          break;
      }
      snackBar.show(errorMessage);
      return repositories;
    }
  }

  Future<void> searchRepositories(BuildContext context) async {
    final repositories = await fetchRepositories(state.value!.searchWord, context);
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
