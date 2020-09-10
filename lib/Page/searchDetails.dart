import 'package:flutter/material.dart';
import 'package:coba_part2/Network/ApiClient.dart';
import 'package:coba_part2/Page/Image.dart';


class SearchDetails extends StatefulWidget {
  final String searchText;
  SearchDetails(this.searchText);

  @override
  _SearchDetailsState createState() => _SearchDetailsState();
}

class _SearchDetailsState extends State<SearchDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text(
          "Search Result",
          style: TextStyle(
            fontSize: 16
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getPics(widget.searchText),
        builder: (context, snapshot){
          final Map data = snapshot.data;
          print(snapshot);
          if(snapshot.hasError){
            return Center(
                child: Text(
                  "Some error occurred",
                  style: TextStyle(fontSize: 16.0, color: Colors.red),
                ));
          }else if (snapshot.hasData){
            if(data["total"] == 0){
              return Center(
                  child: Text(
                    "Photo Not found \n Check Your Keyword !!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0, color: Colors.red),
                  ));
            }else {
              return ListView.builder(
                  itemCount: (data["hits"] as List).length,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        String url = data['hits'][index]['largeImageURL'];
                        String user = data['hits'][index]['user'];
                        String photoUser = data['hits'][index]['userImageURL'];
                        int view = data['hits'][index]['views'];
                        int download = data['hits'][index]['downloads'];
                        int favorites = data['hits'][index]['favorites'];
                        Navigator.push(
                            context,
                          MaterialPageRoute(
                            builder: (context) => Images(url,user,photoUser,view,download,favorites),
                          ),
                        );
                      },
                      child: Container(
                        constraints: BoxConstraints.tightFor(
                            width: 0.0, height: 220),
                        child: ListTile(
                          contentPadding: const EdgeInsets.fromLTRB(
                              10, 13, 10, 0),
                          title: Image.network(
                            data['hits'][index]['largeImageURL'],
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    );
                  }
              );
            }
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
