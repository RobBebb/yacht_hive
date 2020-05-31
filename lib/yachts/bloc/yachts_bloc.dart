import 'package:bloc/bloc.dart';
import 'package:flutter/rendering.dart';

import '../domain/yacht.dart';
import '../domain/yacht_service.dart';
import './bloc.dart';

class YachtsBloc extends Bloc<YachtsEvent, YachtsState> {
  final YachtService yachtService;

  YachtsBloc(this.yachtService);

  @override
  YachtsState get initialState => YachtsLoadInProgress();

  @override
  Stream<YachtsState> mapEventToState(
    YachtsEvent event,
  ) async* {
    if (event is YachtsLoaded) {
      yield* _mapYachtsLoadedToState();
    } else if (event is YachtAdded) {
      yield* _mapYachtAddedToState(event);
    } else if (event is YachtUpdated) {
      yield* _mapYachtUpdatedToState(event);
    } else if (event is YachtDeleted) {
      yield* _mapYachtDeletedToState(event);
    }
  }

  Stream<YachtsState> _mapYachtsLoadedToState() async* {
    try {
      final yachts = await this.yachtService.loadYachts();
      yield YachtsLoadSuccess(yachts);
    } catch (_) {
      yield YachtsLoadFailure();
    }
  }

  Stream<YachtsState> _mapYachtAddedToState(YachtAdded event) async* {
    try {
      final yachts = await this.yachtService.addYacht(event.yacht);
      yield YachtsLoadSuccess(yachts);
    } catch (_) {
      yield YachtsLoadFailure();
    }
  }

  Stream<YachtsState> _mapYachtUpdatedToState(YachtUpdated event) async* {
    try {
      final yachts = await this.yachtService.updateYacht(event.index, event.yacht);
      yield YachtsLoadSuccess(yachts);
    } catch (_) {
      yield YachtsLoadFailure();
    }
  }

  Stream<YachtsState> _mapYachtDeletedToState(YachtDeleted event) async* {
    try {
      final yachts = await this.yachtService.deleteYacht(event.index);
      yield YachtsLoadSuccess(yachts);
    } catch (_) {
      yield YachtsLoadFailure();
    }
  }

}
