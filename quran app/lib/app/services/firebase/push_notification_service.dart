import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' show Random;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:quran_app/app/res/strings/strings.dart';

//TODO: needed
import 'package:quran_app/app/utils/debug_utils/debug_utils.dart';
// import 'package:quran_app/app/utils/pref_keys.dart';
// import 'package:quran_app/app/utils/prefs.dart';
// import 'package:quran_app/app/services/navigator_service.dart';

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

//TODO: needed
var android = const AndroidInitializationSettings('mipmap/ic_noti');
final InitializationSettings initializationSettings = InitializationSettings(
  android: android,
  iOS: initializationSettingsDarwin,
);
final List<DarwinNotificationCategory> darwinNotificationCategories =
<DarwinNotificationCategory>[
  DarwinNotificationCategory(
    darwinNotificationCategoryText,
    actions: <DarwinNotificationAction>[
      DarwinNotificationAction.text(
        'text_1',
        'Action 1',
        buttonTitle: 'Send',
        placeholder: 'Placeholder',
      ),
    ],
  ),
  const DarwinNotificationCategory(
    darwinNotificationCategoryPlain,

    options: <DarwinNotificationCategoryOption>{
      DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
    },
  )
];

/// Note: permissions aren't requested here just to demonstrate that can be
/// done later
final DarwinInitializationSettings initializationSettingsDarwin =
DarwinInitializationSettings(
  requestAlertPermission: false,
  requestBadgePermission: false,
  requestSoundPermission: false,
  onDidReceiveLocalNotification:
      (int id, String? title, String? body, String? payload) async {
    didReceiveLocalNotificationStream.add(
      ReceivedNotification(
        id: id,
        title: title,
        body: body,
        payload: payload,
      ),
    );
  },
  notificationCategories: darwinNotificationCategories,
);

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

/// A notification action which triggers a url launch event

const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';
const String darwinNotificationCategoryText = 'textCategory';
const String darwinNotificationCategoryPlain = 'plainCategory';
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream =
StreamController<String?>.broadcast();

class PushNotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  Map<String, dynamic>? msgOnLocal;

  String? selectedNotificationPayload;


  Future initialise() async {
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject(); // foreground notification clicks handle function

    var deviceToken = await FirebaseMessaging.instance.getToken();
    // Just for testing will remove in future
    DebugUtils.showLog(deviceToken!, prefix: "Device/FCM Token >> ");
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {
          switch (notificationResponse.notificationResponseType) {
            case NotificationResponseType.selectedNotification:
              selectNotificationStream.add(notificationResponse.payload);
              break;
            case NotificationResponseType.selectedNotificationAction:
              if (notificationResponse.actionId == navigationActionId) {
                selectNotificationStream.add(notificationResponse.payload);
              }
              break;
          }
        },
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground);

    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
        critical: true,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
        critical: true,
      );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      await androidImplementation?.requestPermission();
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      if (Platform.isAndroid) _showNotificationWithActions(event);
      DebugUtils.showLog(
          "onNotificationForeground >> ${event.data} ");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      DebugUtils.showLog(
          "onNotificationOpenedAPP >> ${message.data} ");
    });
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationStream.stream
        .listen((ReceivedNotification receivedNotification) async {

    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) async {
      DebugUtils.showLog(
          "onNotificationSelect>> $payload ");
    });
  }

  Future<void> _showNotificationWithActions(RemoteMessage event) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      AppStrings.appName,
      AppStrings.appName,
      channelDescription: AppStrings.appName,
      priority: Priority.high,
      importance: Importance.high,
    );

    const DarwinNotificationDetails iosNotificationDetails =
    DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      categoryIdentifier: darwinNotificationCategoryPlain,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
    var title = event.notification!.title!;
    var body = event.notification!.body!;

    await flutterLocalNotificationsPlugin.show(
        Random().nextInt(9999), title, body, notificationDetails,
        payload: json.encode(event
            .data));
  }
}
