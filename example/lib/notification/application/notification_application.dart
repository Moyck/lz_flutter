import 'package:flutter_apns/flutter_apns.dart';
import 'package:flutter_hms_gms_availability/flutter_hms_gms_availability.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:huawei_push/huawei_push.dart' as huawei;
import 'package:injectable/injectable.dart';
import 'package:flutter_apns/apns.dart';


@singleton
@injectable
class NotificationApplication {

  Future<void> init() async {
    FlutterHmsGmsAvailability.isHmsAvailable.then((t) async {
      if(t){
        huawei.Push.getTokenStream.listen(_onTokenEvent);
        huawei.Push.onNotificationOpenedApp.listen(_onNotificationOpenedApp);
        huawei.Push.onMessageReceivedStream
            .listen(_onMessageReceived);
        huawei.Push.getToken('');
      }else{
      final connector = createPushConnector();
      connector.configure(
          onLaunch: onPush,
          onResume: onPush,
          onMessage: onPush,
          onBackgroundMessage: onBackgroundMessage
      );
      connector.token.addListener(
              ()  => onTokenRefresh(connector.token.value!));
      connector.requestNotificationPermissions();
    }});
  }

  Future onTokenRefresh(String token) async {
    print(token);
  }

  Future onPush(RemoteMessage message) async {
    print(message);
  }

  Future onBackgroundMessage(RemoteMessage message) async {
    print(message);
  }

  Future<void> _onMessageReceived(huawei.RemoteMessage remoteMessage) async {

  }

  Future<void> _onNotificationOpenedApp(dynamic initialNotification) async {

  }

  Future<void> _onTokenEvent(String event) async {

  }

}
