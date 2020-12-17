part of 'search_bloc.dart';

@immutable
class SearchState {
  final bool manualSelection;
  final List<SearchResutl> history;

  SearchState({this.manualSelection = false, List<SearchResutl> history})
      : this.history = (history == null) ? [] : history;

  copyWith({bool manualSelection, List<SearchResutl> history}) => SearchState(
      manualSelection: manualSelection ?? this.manualSelection,
      history: history ?? this.history);
}
