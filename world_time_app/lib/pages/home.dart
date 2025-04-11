import 'dart:developer';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    // Get the arguments passed from the previous screen
    data = data.isEmpty ? data :  ModalRoute.of(context)?.settings.arguments as Map? ?? {};

    log(data.toString());

    // set background image with null safety
    String bgImage = (data['isDaytime'] ?? false) ? 'day.png' : 'night.png';
    String bgImagePath = '/$bgImage';
    log("image path is $bgImagePath");

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bgImagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                Text('home page'),
                ElevatedButton.icon(
                  onPressed: () async{
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'location': result['location'],
                        'flag': result['flag'],
                        'time': result['time'],
                        'isDaytime': result['isDaytime'],
                      };
                    }); 
                  },
                  icon: Icon(Icons.edit_location, color: Colors.grey[200]),
                  label: Text('choose location'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    foregroundColor: Colors.grey[300],
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'] ?? '',
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  data['time'] ?? '',
                  style: TextStyle(fontSize: 66.0, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
