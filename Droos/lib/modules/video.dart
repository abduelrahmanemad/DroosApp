
import 'dart:isolate';
import 'dart:ui';

import 'package:droos/modules/web.dart';
import 'package:droos/shared/comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../shared/const.dart';

class LecVideo extends StatefulWidget {
  String? lecUrl='';
  String? name='';
  String? malzamaUrl='';
  String? examUrl='';
  LecVideo(this.lecUrl,this.malzamaUrl,this.examUrl,this.name);


  @override
  State<StatefulWidget> createState() {
    return _LecVideoState(lecUrl,malzamaUrl,examUrl,name);
  }
}

class _LecVideoState extends State<LecVideo> {
  String? name='';
  String? lecUrl='';
  String? malzamaUrl='';
  String? examUrl='';
  int progress =0;
  _LecVideoState(this.lecUrl,this.malzamaUrl,this.examUrl,this.name);
  YoutubePlayerController? _youtubePlayerController;
  var futureFiles;
  ReceivePort receivePort =ReceivePort();
  @override
  void initState() {
    IsolateNameServer.registerPortWithName(receivePort.sendPort, "Downloading");
    receivePort.listen((message) {
      setState(() {
        progress=message;
      });
    });
    FlutterDownloader.registerCallback(downLoadCallback);

    if(lecUrl!='') {
      final videoId = YoutubePlayer.convertUrlToId(lecUrl!);
      _youtubePlayerController = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: const YoutubePlayerFlags(
            controlsVisibleAtStart: true,
            enableCaption: false,
            autoPlay: false,
            hideThumbnail: true
        ),
      );
    }


    super.initState();
  }

  static downLoadCallback(id, status, progress){
    SendPort? sendPort = IsolateNameServer.lookupPortByName('Downloading');
    sendPort!.send(progress);
  }

  Future downloadFile() async {
    final status = await Permission.storage.request();
    if(status.isGranted){
      final basStorage = await getExternalStorageDirectory();
      final id = await FlutterDownloader.enqueue(url: '$malzamaUrl', savedDir: basStorage!.path,fileName: 'Malzama $name');
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Downloaded')));
  }



  @override
  Widget build(BuildContext context) {
    if(lecUrl!='') {
      return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _youtubePlayerController!,
          showVideoProgressIndicator: true,
        ),
        builder: (context,player){
          return Scaffold(
              appBar: AppBar(
                title:  Text('$name',style: const TextStyle(color: darkText),),
              ),
              body:ListView(
                children: [
                  if(lecUrl!='')
                    player,
                  SizedBox(height: 20.h,),
                  if(malzamaUrl!='')
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: (){
                            downloadFile();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(blue),
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                            padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 14.h)),
                            textStyle: MaterialStateProperty.all(TextStyle(
                              fontSize: 16.sp,
                            )),
                          ),
                          child: const Text('Download PDF'),
                        ),
                      ),
                    ),
                  if(examUrl!='')
                    SizedBox(height: 7.h,),
                  if(examUrl!='')
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 15.0.w),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: (){
                            navigateTo(context, WebViewScreen(examUrl!));
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(blue),
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                            padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 14.h)),
                            textStyle: MaterialStateProperty.all(TextStyle(
                              fontSize: 16.sp,
                            )),
                          ),
                          child: const Text('Exam'),
                        ),
                      ),
                    ),

                ],

              )
          ) ;
        }
    );
    }else{
      return Scaffold(
          appBar: AppBar(
            title:  Text('$name',style: const TextStyle(color: darkText),),
          ),
          body:ListView(
            children: [
              SizedBox(height: 10.h,),
              if(malzamaUrl!='')
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: (){
                        downloadFile();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(blue),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 14.h)),
                        textStyle: MaterialStateProperty.all(TextStyle(
                          fontSize: 16.sp,
                        )),
                      ),
                      child: const Text('Download PDF'),
                    ),
                  ),
                ),
              if(examUrl!='')
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: (){
                        navigateTo(context, WebViewScreen(examUrl!));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(blue),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 14.h)),
                        textStyle: MaterialStateProperty.all(TextStyle(
                          fontSize: 16.sp,
                        )),
                      ),
                      child: const Text('Exam'),
                    ),
                  ),
                ),

            ],

          )
      );
    }
  }
}
