import 'package:flutter_engineer_codecheck/home/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      ),
    );
  }
}
