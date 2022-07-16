import 'package:flutter_engineer_codecheck/models/repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default("") String searchWord,
    @Default([]) List<Repository> repositories,
  }) = _HomeState;
}
