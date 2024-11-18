import 'package:flutter/material.dart';
import 'package:music_player/view/screens/videoview.dart';
import 'audioview.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: const Text(
            'Music player',
            style: TextStyle(fontSize: 24,color: Colors.white,),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 2,
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white,),
            tabs: [
              Tab(icon: Icon(Icons.audiotrack, size: 28,color: Colors.white,), text: 'Audios',),
              Tab(icon: Icon(Icons.videocam, size: 28,color: Colors.white), text: 'Videos',),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AudioView(),
            VideoView(),
          ],
        ),

      ),
    );
  }
}
