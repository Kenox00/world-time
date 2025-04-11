import 'dart:developer';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  late String time; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint
  late bool isDaytime; // true or false if daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    String apiKey = "87fc26819db84f4a835266207232a421";

    try {
      // make reuest
      Response response = await get(
        Uri.parse(
          'https://timezone.abstractapi.com/v1/current_time/?api_key=$apiKey&location=$url',
        ),
      );
      Map data = jsonDecode(response.body); // Decode the response body

      // get properties from json
      String datetime = data['datetime'];
      int offset = data['gmt_offset'];

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: offset.toInt()));

      // set the time property
      isDaytime = now.hour > 6 && now.hour < 18 ? true : false; // check if daytime
      time = DateFormat.jm().format(now); // format the time
    } catch (e) {
      log('Caught Error: $e');
      time =
          'Could not get time data'; // set the time property to an error message
    }
  }
}
