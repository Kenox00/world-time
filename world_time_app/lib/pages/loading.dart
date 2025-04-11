import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupWorldTime({
    String location = 'Berlin',
    String flag = 'germany.png',
    String url = 'Berlin, Germany',
  }) async {
    WorldTime instance = WorldTime(location: location, flag: flag, url: url);
    await instance.getTime();
    // Navigate to home screen after getting the time
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(
      context,
      '/home',
      arguments: {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDaytime': instance.isDaytime,
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(child: SpinKitFadingCircle(color: Colors.white, size: 80.0)),
    );
  }
}
