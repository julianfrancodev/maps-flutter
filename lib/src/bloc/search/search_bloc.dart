import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mapbox_flutter/src/models/search_result.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is OnEnablePinManual) {
      yield state.copyWith(manualSelection: true);
    } else if (event is OnDisablePinManual) {
      yield state.copyWith(manualSelection: false);
    } else if (event is OnAddHistory) {
      final exists = state.history
          .where((result) => result.destiny == event.result.destiny)
          .length;

      if(exists == 0){
        final newHistory = [...state.history, event.result];

        yield state.copyWith(history: newHistory);
      }

    }
  }
}
