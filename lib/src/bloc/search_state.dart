part of 'search_bloc.dart';

@immutable
class SearchState {
  final bool manualSelection;

  SearchState({this.manualSelection = false});

  copyWith({bool manualSelection}) =>
      SearchState(manualSelection: manualSelection ?? this.manualSelection);
}
