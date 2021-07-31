part of 'universal_cubit.dart';

@immutable
abstract class UniversalState {}

class UniversalInitial extends UniversalState {}

class UniversalLoadingState extends UniversalState {}

class UniversalLoadedState extends UniversalState{
  final  list;
  UniversalLoadedState({@required this.list}) : assert(list != null);
}

class UniversalDetailLoadedState extends UniversalState{
  final  response;
  UniversalDetailLoadedState({@required this.response})
      : assert(response != null);
}

class UniversalErrorState extends UniversalState {}
