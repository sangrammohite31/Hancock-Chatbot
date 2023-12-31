import 'package:flutter/material.dart';
import 'package:hancock/entrance.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hancock',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true)
       
      
       
    ,
      home:  Entrance()
    );
  }
}
