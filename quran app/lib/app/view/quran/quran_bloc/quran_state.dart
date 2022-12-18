part of 'quran_bloc.dart';

/// {@template quran_state}
/// QuranState description
/// {@endtemplate}
class QuranState extends Equatable {
  /// {@macro quran_state}
  const QuranState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current QuranState with property changes
QuranState copyWith({
    String? customProperty,
  }) {
    return QuranState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template quran_initial}
/// The initial state of QuranState
/// {@endtemplate}
class QuranInitial extends QuranState {
  /// {@macro quran_initial}
  const QuranInitial() : super();
}
