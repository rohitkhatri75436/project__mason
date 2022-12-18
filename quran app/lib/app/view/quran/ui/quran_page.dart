import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/app/view/quran/quran_bloc/quran_bloc.dart';
import 'package:quran_app/app/global_widgets/text_widget.dart';


/// {@template custom_page}
/// A description for CustomPage
/// {@endtemplate}
class QuranPage extends StatelessWidget {
  /// {@macro custom_page}
  const QuranPage({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuranBloc(),
      child:  const Scaffold(
                backgroundColor: Colors.white,
                body: Center(child: TextWidget(text: 'Hello world',)),
      ),
    );
  }
}

