import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:dio/dio.dart';


// ignore: must_be_immutable
class Images extends StatefulWidget {
  String url;
  String user;
  String photoUser;
  int view;
  int download;
  int favorites;
  Images(this.url,this.user,this.photoUser, this.view, this.download, this.favorites);
  @override
  _ImagesState createState() => _ImagesState();
}

class _ImagesState extends State<Images> {

  _save() async {
    var response = await Dio().get(
        widget.url,
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: widget.user);
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text(
          "Image",
          style: TextStyle(
              fontSize: 16
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10,left: 10,top: 10,bottom: 40),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 20.0,
                      offset: Offset(0, 5)
                  )
                ]
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    child: Image.network(widget.url),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget.photoUser),
                      ),
                      SizedBox(width: 10),
                      Text(
                        widget.user,
                        style: TextStyle(
                            fontSize: 14
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.remove_red_eye,size: 20,color: Colors.blueAccent,),
                          SizedBox(width: 10),
                          Text(
                            (widget.view).toString(),
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.cloud_download,size: 20,color: Colors.green),
                          SizedBox(width: 10),
                          Text(
                            (widget.download).toString(),
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.star,size: 20,color: Colors.redAccent),
                          SizedBox(width: 10),
                          Text(
                            (widget.favorites).toString(),
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              ],
            ),
          )
        ],
      ),
      floatingActionButton: Container(
        width: 60.0,
        height: 60.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(Icons.file_download,color: Colors.white,size: 23),
            backgroundColor: Colors.purpleAccent,
            onPressed: () {
              _save();
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
