import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'api_msg_strings.dart';

class NetworkUtil {
  NetworkUtil._();

//show ProgressDialog
/* static void showProgressDialog() {
    Widget _drawerWidget = Container(
      child: const SafeArea(
        child: SizedBox.expand(
          child: ProgressWidget(),
        ),
      ),
      color: Colors.transparent,
    );

    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.3),
      transitionDuration: const Duration(milliseconds: 50),
      context: NavigationService.navigatorKey.currentContext!,
      pageBuilder: (_, __, ___) {
        return _drawerWidget;
      },
    );
  }*/
}

//ProgressDialog
//This class is used for custom progress widget for ios
class ProgressWidget extends StatelessWidget {
  final String? msg;
  const ProgressWidget({Key? key, this.msg = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 120.0,
        width: 160.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const CupertinoActivityIndicator(),
            if(msg!.isEmpty)
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Text(
                ApiMsgStrings.txtPleaseWait,
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14.0,
                    decoration: TextDecoration.none),
              ),
            ),
            if (msg!.isNotEmpty)
               Padding(
                padding:const EdgeInsets.fromLTRB(2, 16, 2, 0),
                child: Text(msg!,
                  style:const TextStyle(
                      color: Colors.black54,
                      fontSize: 14.0,
                      decoration: TextDecoration.none),
                ),
              ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
