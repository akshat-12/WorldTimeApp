import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      print('in gettime');
      var u = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      Response response = await get(u);
      print('in gettime');
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      isDayTime = now.hour > 6 && now.hour < 20;
      print('got daytime');
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Caught error : $e');
      time = 'Error retrieving time';
      isDayTime = true;
    }
  }
}
