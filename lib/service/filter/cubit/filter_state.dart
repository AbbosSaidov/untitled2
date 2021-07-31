part of 'filter_cubit.dart';

@immutable
abstract class FilterState{}

class FilterInitial extends FilterState{}

class FilterLoadingState extends FilterState{}

class FilterLoadedState extends FilterState{
  final CategoryResponseModel res;

  FilterLoadedState({@required this.res}):assert(res!=null);
}
class FilterLoadedMainState extends FilterState{
  final  res;

  FilterLoadedMainState({@required this.res}):assert(res!=null);
}


class FilterErrorState extends FilterState{}