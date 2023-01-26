part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class LoadingSearchState extends SearchState {}

class SuccessSearchState extends SearchState {}

class ErrorSearchState extends SearchState {}

class LoadingSearchBarState extends SearchState {}

class SuccessSearchBarState extends SearchState {}

class ErrorSearchBarState extends SearchState {}
