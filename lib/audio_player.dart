import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

class Audio extends StatefulWidget {
  const Audio({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Audio> createState() => _AudioState();
}

class _AudioState extends State<Audio> {

  //variable
  Color bgColor = Colors.black54;
  //player
  final AudioPlayer _player = AudioPlayer();

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        backgroundColor: bgColor,
      ),
      body:  FutureBuilder<String>(
        future: DefaultAssetBundle.of(context).loadString("AssetManifest.json"),
        builder: (context, item){
          if(item.hasData){

            Map? jsonMap = json.decode(item.data!);
            List? songs = jsonMap?.keys.toList();
            return ListView.builder(
              itemCount: songs?.length,
              itemBuilder: (context, index){
                var path = songs![index].toString();
                var title = path.split("/").last.toString(); //get file name
                title = title.replaceAll("%20", ""); //remove %20 characters
                title = title.split(".").first;

                return Container(
                  margin: const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(4.0),
                    boxShadow: const[
                      BoxShadow(
                        blurRadius: 4.0,
                        offset: Offset(-4, -4),
                        color: Colors.white24,
                      ),
                      BoxShadow(
                        blurRadius: 4.0,
                        offset: Offset(4, 4),
                        color: Colors.black,
                      ),
                    ],
                    border: Border.all(color: Colors.white70, width: 3.0, style: BorderStyle.solid),
                  ),

                  child: ListTile(
                    textColor: Colors.white,
                    title: Text(title),
                    subtitle: Text("path: $path",
                      style: const TextStyle(color: Colors.white70, fontSize: 12),),
                    leading: const Icon(Icons.audiotrack, size: 20, color: Colors.white70,),
                    onTap: () async{
                      toast(context, "Playing: $title");
                      //play this song
                      await _player.setAsset(path);
                      await _player.play();
                    },
                  ),
                );
              },
            );
          }else{
            return const Center(
              child: Text("No Songs in the Assets"),
            );
          }
        },
      ),
    );
  }

  //A toast method
  void toast(BuildContext context, String text){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, textAlign: TextAlign.center,),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    ));
  }
}