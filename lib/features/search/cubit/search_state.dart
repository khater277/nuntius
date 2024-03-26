part of 'search_cubit.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = _Initial;
  const factory SearchState.initControllers() = _InitControllers;
  const factory SearchState.disposeControllers() = _DisposeControllers;
  const factory SearchState.onChangeSearchTextField(String value) =
      _OnChangeSearchTextField;
  const factory SearchState.clearSearchTextField() = _ClearSearchTextField;
}
