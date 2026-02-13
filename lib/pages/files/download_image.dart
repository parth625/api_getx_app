import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DownloadImage extends StatefulWidget {
  const DownloadImage({super.key});

  @override
  State<DownloadImage> createState() => _DownloadImageState();
}

class _DownloadImageState extends State<DownloadImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Download and Image')),
      body: Column(
        mainAxisAlignment: .center,
        children: [
          Image.network(
            'https://repository-images.githubusercontent.com/31792824/fb7e5700-6ccc-11e9-83fe-f602e1e1a9f1',
          ),
          ElevatedButton(
            onPressed: downloadImage,
            child: Text('Download Image'),
          ),
        ],
      ),
    );
  }

  Future<void> downloadImage() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Dio dio = Dio(
        BaseOptions(responseType: ResponseType.bytes)
    );

    String url =
        'https://repository-images.githubusercontent.com/31792824/fb7e5700-6ccc-11e9-83fe-f602e1e1a9f1';
    final response = await dio.get(
      'https://repository-images.githubusercontent.com/31792824/fb7e5700-6ccc-11e9-83fe-f602e1e1a9f1',
    );

    log('${response.headers}');
    // Directory? dir = await getDownloadsDirectory();
    String path = '/storage/emulated/0/Download/$fileName.png';
    await dio.download(url, path, onReceiveProgress: (received, total) {
      if(total != -1){
        log('Download progress: ${(received/total * 100)}%');
      }
    },);

    Get.snackbar(
      "Success",
      "The image downloaded",
      snackPosition: SnackPosition.TOP,
    );
    // log('$dir');
    // log('${dir?.path}');
  }
}
