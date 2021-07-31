part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final  res;
  SearchLoadedState({@required this.res}) : assert(res != null);
}

class SearchErrorState extends SearchState {}
