import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:qlcv/system/Config/build_infomation.dart';
import 'package:qlcv/system/Config/firebase_config.dart';
import 'package:qlcv/system/Config/global_params.dart';
import 'package:qlcv/system/Config/lifecycle_event_config.dart';
import 'package:qlcv/system/Config/model_map_config.dart';
import 'package:qlcv/system/Config/notifi_config.dart';
import 'package:qlcv/system/_base/model/content/bloc_status.dart';
import 'package:qlcv/system/_base/model/content/global_model.dart';
import 'package:qlcv/system/_base/model/model_scaffold/view_content_modal.dart';
import 'package:qlcv/system/observer/app_observer.dart';
import 'package:qlcv/system/user/user_data_component.dart';
import 'base/controller/main/main_bloc.dart';
import 'model/login/login_router.dart';

final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'thongbao.net.vn', 'Thông báo', // title, // description
  importance: Importance.high,
);

final GlobalModel globalModel = GlobalModel.instance();
final ViewContentModal viewContentModal = ViewContentModal.instance();
// ignore: unnecessary_new
late final MainApp mainApp;
String? token;
String? statusMobile;
String? defaultUrl = "";
String? messageTitle;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  StartMap.mapModal();

  await FlutterDownloader.initialize(
      debug: true,
      // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          false // option: set to false to disable working with http links (default: false)
      );
  await StartNotification.configNotification();

  await StartFirebase.configFirebase(globalModel);
  await StartFirebase.initFirebase(globalModel);

  Bloc.observer = AppObserver();
  WidgetsFlutterBinding.ensureInitialized();
  token = await UserDataComponent().getAppToken();
  if (token != null && token != "") {
    await buildUserInfomation(token!, globalModel);
  }
  runApp(MainApp(globalModel));
}

// ignore: must_be_immutable
class MainApp extends StatefulWidget {
  late GlobalModel globalModal;

  // ignore: use_key_in_widget_constructors
  MainApp(this.globalModal);

  @override
  // ignore: no_logic_in_create_state
  MainAppState createState() => MainAppState(globalModal);
}

class MainAppState extends State<MainApp> with WidgetsBindingObserver {
  late GlobalModel globalModal;

  MainAppState(this.globalModal);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addObserver(this);

    StartNotification.requestPermission();

    notificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    return BlocProvider(
      create: (_) => MainBloc(globalModel: globalModel),
      // ignore: unnecessary_null_comparison, prefer_const_constructors
      child: AppView(),
    );
  }

  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
    WidgetsBinding.instance.addObserver(
      LifecycleEventHandler(
        resumeCallBack: () async => setState(
          () {
            // globalModal.broadcastEventBus.fire(MessageModal("APP:ON"));
          },
        ),
      ),
    );
  }

  void setupInteractedMessage() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      StartNotification.showRemoteMessage(message);
    });
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _AppViewState();
}

// ignore: camel_case_types
class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: GlobalParams.getGlobalKeyNavigatorState(),
      home: FlowBuilder<BlocStatus>(
        state: context.select((MainBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
