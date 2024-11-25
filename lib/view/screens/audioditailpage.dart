import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class AudioDetailPage extends StatefulWidget {
  final AssetsAudioPlayer player;

  const AudioDetailPage({
    super.key,
    required this.player, required Audio audio,
  });

  @override
  State<AudioDetailPage> createState() => _AudioDetailPageState();
}

class _AudioDetailPageState extends State<AudioDetailPage> {
  bool isLiked = false;

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
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
          'Music Player',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: StreamBuilder<Playing?>(
            stream: widget.player.current,
            builder: (context, snapshot) {
              final playing = snapshot.data;
              final currentAudio = playing?.audio;
              final metas = currentAudio?.audio.metas;

              if (currentAudio == null || metas == null) {
                return const Center(
                  child: Text(
                    "No audio playing",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                );
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 260,
                      height: 260,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: const LinearGradient(
                          colors: [Colors.purple, Colors.blue],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: metas.image?.path != null
                            ? Image.network(
                          metas.image!.path,
                          fit: BoxFit.fill,
                        )
                            : const Icon(
                          Icons.music_note,
                          size: 150,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  
                  Column(
                    children: [
                      Text(
                        metas.title ?? "Unknown Title",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        metas.artist ?? "Unknown Artist",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      IconButton(
                        onPressed: toggleLike,
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),

                 
                  StreamBuilder<Duration>(
                    stream: widget.player.currentPosition,
                    builder: (context, snapshot) {
                      final currentPosition = snapshot.data ?? Duration.zero;
                      final totalDuration = currentAudio.duration;

                      return Column(
                        children: [
                          Slider(
                            value: currentPosition.inSeconds.toDouble(),
                            max: totalDuration.inSeconds.toDouble(),
                            onChanged: (value) {
                              widget.player.seek(Duration(seconds: value.toInt()));
                            },
                            activeColor: Colors.grey,
                            inactiveColor: Colors.white24,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${currentPosition.inMinutes}:${(currentPosition.inSeconds % 60).toString().padLeft(2, '0')}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                                Text(
                                  "${totalDuration.inMinutes}:${(totalDuration.inSeconds % 60).toString().padLeft(2, '0')}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          widget.player.previous();
                        },
                        icon: const Icon(Icons.skip_previous),
                        iconSize: 50,
                        color: Colors.white,
                      ),
                      StreamBuilder<bool>(
                        stream: widget.player.isPlaying,
                        builder: (context, snapshot) {
                          final isPlaying = snapshot.data ?? false;
                          return IconButton(
                            onPressed: () {
                              widget.player.playOrPause();
                            },
                            icon: Icon(
                              isPlaying
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_filled,
                            ),
                            iconSize: 70,
                            color: Colors.white,
                          );
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          widget.player.next();
                        },
                        icon: const Icon(Icons.skip_next),
                        iconSize: 50,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
