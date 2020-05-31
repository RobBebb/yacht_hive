import 'package:equatable/equatable.dart';

import '../domain/yacht.dart';

/// 
/// YachtsLoaded - tells the bloc that it needs to load the yachts from the
///                     database.
/// YachtAdded - tells the bloc that it needs to add a new yacht to the list of
///                     yachts.
/// YachtUpdated - tells the bloc that it needs to update an existing yacht.
/// YachtDeleted - tells the bloc that it needs to remove an existing yacht.
/// 

abstract class YachtsEvent extends Equatable {
  const YachtsEvent();

  @override 
  List<Object> get props => [];
}


class YachtsLoaded extends YachtsEvent {}


class YachtAdded extends YachtsEvent {
  final Yacht yacht;

  const YachtAdded(this.yacht);

  @override 
  List<Object> get props => [];

  @override 
  String toString() => 'YachtAdded (yacht: $yacht)';
}


class YachtUpdated extends YachtsEvent {
  final int index;
  final Yacht yacht;

  const YachtUpdated(this.index, this.yacht);

  @override 
  List<Object> get props => [];

  @override 
  String toString() => 'YachtUpdated (yacht: $yacht) at index $index';
}


class YachtDeleted extends YachtsEvent {
  final int index;

  const YachtDeleted(this.index);

  @override 
  List<Object> get props => [];

  @override 
  String toString() => 'YachtDeleted at index $index)';
}