import 'package:flutter/material.dart';
import 'package:{{{app_name.snakeCase()}}}/app/view/{{{feature_name.snakeCase()}}}/{{{feature_name.snakeCase()}}}.dart';
import 'package:{{{app_name.snakeCase()}}}/l10n/l10n.dart';
import 'package:{{{app_name.snakeCase()}}}/app/res/size_values/size_config.dart';
import 'package:{{{app_name.snakeCase()}}}/app/res/strings/strings.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(
          context,
        );
        if (!currentFocus.hasPrimaryFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        title: AppStrings.appName,
          theme: ThemeData(
            fontFamily: 'Poppins',
            scaffoldBackgroundColor: Colors.black,
          ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) {
          SizeConfig.initialize(
            context: context,
            draftWidth: 375,
            draftHeight: 812,
          );
          return child!;
        },
      home: {{{feature_name.pascalCase()}}}Page(),
    ));
  }
}
