part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class OnEnablePinManual extends SearchEvent{}

class OnDisablePinManual extends SearchEvent{}
