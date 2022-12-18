part of 'quran_bloc.dart';

abstract class QuranEvent  extends Equatable {
  const QuranEvent();
}

/// {@template custom_quran_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class CustomQuranEvent extends QuranEvent {
  /// {@macro custom_quran_event}
  const CustomQuranEvent();


  @override
  List<Object> get props => [];

}
