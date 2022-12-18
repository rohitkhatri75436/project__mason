import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{{app_name.snakeCase()}}}/app/view/{{{feature_name.snakeCase()}}}/{{{feature_name.snakeCase()}}}_bloc/{{{feature_name.snakeCase()}}}_bloc.dart';
import 'package:{{{app_name.snakeCase()}}}/app/global_widgets/text_widget.dart';


/// {@template custom_page}
/// A description for CustomPage
/// {@endtemplate}
class {{{feature_name.pascalCase()}}}Page extends StatelessWidget {
  /// {@macro custom_page}
  const {{{feature_name.pascalCase()}}}Page({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => {{{feature_name.pascalCase()}}}Bloc(),
      child:  const Scaffold(
                backgroundColor: Colors.white,
                body: Center(child: TextWidget(text: 'Hello world',)),
      ),
    );
  }
}

