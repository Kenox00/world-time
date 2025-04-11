import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(
      url: 'London, United Kingdom',
      location: 'London',
      flag: 'uk.png',
    ),
    WorldTime(url: 'Berlin, Germany', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Cairo, Egypt', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Nairobi, Kenya', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(
      url: 'Chicago, United States',
      location: 'Chicago',
      flag: 'usa.png',
    ),
    WorldTime(
      url: 'New York, United States',
      location: 'New York',
      flag: 'usa.png',
    ),
    WorldTime(
      url: 'Seoul, South Korea',
      location: 'Seoul',
      flag: 'south_korea.png',
    ),
    WorldTime(
      url: 'Jakarta, Indonesia',
      location: 'Jakarta',
      flag: 'indonesia.png',
    ),
  ];

  void updateTime(index) async{
    WorldTime instance = locations[index];
    await instance.getTime();
      Navigator.pop(
        // ignore: use_build_context_synchronously
        context, {
          'location': instance.location,
          'flag': instance.flag,
          'time': instance.time,
          'isDaytime': instance.isDaytime,
        },
      );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a location'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 5.0),
            child: Card(
              child: ListTile(
                onTap: () => updateTime(index),
                title: Text(
                  locations[index].location,
                  style: TextStyle(fontSize: 20.0),
                ),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('/${locations[index].flag}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
