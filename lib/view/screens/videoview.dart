import 'package:flutter/material.dart';
import 'package:music_player/view/screens/videodetailpage.dart';

class VideoView extends StatelessWidget {
  const VideoView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> videoList = [
      "assets/video/aajkirat.mp4",
      "assets/video/ayihe.mp4",
      "assets/video/meredholna.mp4",
      "assets/video/millners.mp4",
      "assets/video/ramsiya.mp4",
    ];

    final List<String> videoThumbnails = [
      "assets/image/aajkirat.jpg",
      "assets/image/ayinai.jpg",
      "assets/image/meredholn.jpg",
      "assets/image/milleners.jpg",
      "assets/image/ramsiya.jpg",

    ];

    final List<String> videoTitles = [
      "Aaj Ki Raat",
      "Aayi Nai",
      "Mere dholna",
      "Millionaire",
      "Ram shiya",

    ];

    if (videoList.length != videoThumbnails.length ||
        videoList.length != videoTitles.length) {
      throw Exception("Lists videoList, videoThumbnails, and videoTitles must have the same length.");
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: videoList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoDetailScreen(
                          videoPath: videoList[index],
                          thumbnailPath: videoThumbnails[index],
                          videoTitle: videoTitles[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          height: 90,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(videoThumbnails[index]),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              videoTitles[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Bollywood', // Static placeholder
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              '1.5M views • 1 day ago',
                              style: TextStyle(
                                color: Colors.white38,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
