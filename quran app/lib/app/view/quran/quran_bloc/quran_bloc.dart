import 'dart:async';

import 'package:bloc/bloc.dart';          
import 'package:equatable/equatable.dart';
part 'quran_event.dart';
part 'quran_state.dart';

class QuranBloc extends Bloc<QuranEvent, QuranState> {
  QuranBloc() : super(const       QuranInitial()) {
    on<CustomQuranEvent>(_onCustomQuranEvent);
  }

  FutureOr<void> _onCustomQuranEvent(
      CustomQuranEvent event,
    Emitter<QuranState> emit,
  ) {
    // TODO: Add Logic
  }
}
