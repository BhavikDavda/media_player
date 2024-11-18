import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:music_player/view/screens/audioditailpage.dart';

import '../../utils/global.dart';

class AudioView extends StatefulWidget {
  const AudioView({super.key});

  @override
  State<AudioView> createState() => _AudioViewState();
}

class _AudioViewState extends State<AudioView> {
  int cIndex = 0;
  AssetsAudioPlayer player = AssetsAudioPlayer.newPlayer();

  @override
  void initState() {
    super.initState();
    player.open(Playlist(audios: audios), autoStart: false);
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/image/back.webp",
            ),
            fit: BoxFit.cover,
            opacity: 0.3,
          ),
        ),
        child: Scaffold(

          // backgroundColor: Colors.grey.shade200,
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // const Text(
                        //   "Music Library",
                        //   style: TextStyle(
                        //     fontSize: 24,
                        //     fontWeight: FontWeight.bold,
                        //     color: Colors.black87,
                        //   ),
                        // ),
                        //const SizedBox(height: 10),
                        CarouselSlider(
                          items: audios.map((audio) {
                            final meta = audio.metas;
                            return Container(
                              height: 250,
                              width: 250,
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(8),
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(20),
                              //   gradient: LinearGradient(
                              //     colors: [Colors.teal, Colors.grey],
                              //     begin: Alignment.topCenter,
                              //     end: Alignment.bottomCenter,
                              //   ),
                              // ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.shade400,
                                image: DecorationImage(
                                  image: NetworkImage(meta.image!.path),
                                  fit: BoxFit.cover,
                                )
                              ),
                              // child: Column(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     meta.image?.path != null
                              //         ? Image.network(
                              //       meta.image!.path,
                              //       height: 100,
                              //       width: 200,
                              //       fit: BoxFit.cover,
                              //     )
                              //         : Icon(
                              //       Icons.music_note,
                              //       size: 60,
                              //       color: Colors.blueAccent,
                              //     ),
                              //     // const SizedBox(height: 10),
                              //     // Text(
                              //     //   meta.title ?? "Unknown",
                              //     //   style: const TextStyle(
                              //     //     fontSize: 20,
                              //     //     fontWeight: FontWeight.bold,
                              //     //     color: Colors.black,
                              //     //   ),
                              //     //   textAlign: TextAlign.center,
                              //     // ),
                              //   ],
                              // ),
                            );
                          }).toList(),
                          options: CarouselOptions(
                            autoPlay: true,
                            viewportFraction: 0.8,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                cIndex = index;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: audios.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white10,
                  shadowColor: Colors.black,
                  elevation: 7,
                  child: ListTile(
                    onTap: () {
                      player.playlistPlayAtIndex(index);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AudioDetailPage(
                            audio: audios[index],
                            player: player,
                          ),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade900,
                      child: const Icon(
                        Icons.music_note,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      audios[index].metas.title ?? "Unknown",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: StreamBuilder<Playing?>(
                      stream: player.current,
                      builder: (context, snapshot) {
                        final totalDuration = snapshot.data?.audio.duration;
                        return Text(
                          totalDuration != null
                              ? "Duration: ${formatDuration(totalDuration)}"
                              : "Loading...",style: const TextStyle(color: Colors.white),
                        );
                      },
                    ),
                    trailing: const Icon(
                      Icons.play_circle_outline_outlined,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            )
            ]
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),),
                      gradient: LinearGradient(
                        colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
                      ),
                    ),
                    child: StreamBuilder<Playing?>(
                      stream: player.current,
                      builder: (context, snapshot) {
                        Duration? totalDuration = snapshot.data?.audio.duration ?? Duration.zero;

                        return StreamBuilder<Duration>(
                          stream: player.currentPosition,
                          builder: (context, snapshot) {
                            Duration currentPosition = snapshot.data ?? Duration.zero;

                            String formatDuration(Duration duration) {
                              return "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
                            }

                            return Row(
                              children: [
                                IconButton(
                                  onPressed: () => player.previous(),
                                  icon: const Icon(Icons.skip_previous, color: Colors.white, size: 30),
                                ),
                                StreamBuilder<bool>(
                                  stream: player.isPlaying,
                                  builder: (context, snapshot) {
                                    bool isPlaying = snapshot.data ?? false;
                                    return IconButton(
                                      onPressed: () => player.playOrPause(),
                                      icon: Icon(
                                        isPlaying ? Icons.pause : Icons.play_arrow,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  onPressed: () => player.next(),
                                  icon: const Icon(Icons.skip_next, color: Colors.white, size: 30),
                                ),
                                // Slider
                                Expanded(
                                  child: Slider(
                                    min: 0,
                                    max: totalDuration.inSeconds.toDouble(),
                                    value: currentPosition.inSeconds.toDouble(),
                                    onChanged: (value) {
                                      player.seek(Duration(seconds: value.toInt()));
                                    },
                                    activeColor: Colors.white,
                                    inactiveColor: Colors.white38,
                                  ),
                                ),
                                Text(
                                  "${formatDuration(currentPosition)} / ${formatDuration(totalDuration)}",
                                  style: const TextStyle(color: Colors.white, fontSize: 12),
                                ),
                                // Close song button
                                IconButton(
                                  onPressed: () {
                                    player.stop();
                                  },
                                  icon: const Icon(
                                    Icons.close, // Close icon
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}