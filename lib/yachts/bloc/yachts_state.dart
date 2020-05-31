import 'package:equatable/equatable.dart';

import '../domain/yacht.dart';

///
/// YachtsLoadInProgress - the state while the application is fetching yachts
///                        from the database.
/// YachtsLoadSuccess - the state of the application after the yachts have
///                        successfully been loaded.
/// YachtsLoadFailure - the state of the application if the yachts were not
///                        successfully loaded.
///

abstract class YachtsState extends Equatable {
  const YachtsState();

  @override
  List<Object> get props => [];
}


class YachtsLoadInProgress extends YachtsState {

  @override 
  List<Object> get props => [];
}


class YachtsLoadSuccess extends YachtsState {
  final List<Yacht> yachts;

  const YachtsLoadSuccess([this.yachts = const []]);

  @override 
  List<Object> get props => [yachts];

  @override 
  String toString() => 'YachtsLoadSuccess (yachts: $yachts)';
}


class YachtsLoadFailure extends YachtsState {}