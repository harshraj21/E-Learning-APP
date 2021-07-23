import 'package:ntp/ntp.dart';

class NetworkSyncedTime {
  static late int offset;
  static Future<void> initNetworkTime() async {
    offset = await NTP.getNtpOffset(localTime: new DateTime.now());
    // print('time synced successfully');
  }
}
