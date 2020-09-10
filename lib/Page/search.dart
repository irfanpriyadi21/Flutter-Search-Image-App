import 'package:flutter/material.dart';
import 'package:coba_part2/Page/searchDetails.dart';
import 'package:flutter/services.dart';


// ignore: must_be_immutable
class Search extends StatelessWidget {
  TextEditingController searchController = new TextEditingController();
  FocusNode focus = new FocusNode();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:ListView(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 150),
              constraints: BoxConstraints.tightFor(width: 200.0, height: 200.0),
              child: Image.asset(
                "assets/image/photobay2.png",
                fit: BoxFit.scaleDown,
              )
          ),
          SizedBox(height: 10),
          ListTile(
            title: TextFormField(
              focusNode: focus,
              cursorColor: Colors.purpleAccent,
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Eg Dogs, Cats & Bananas",
                labelText: "Enter a category",
                labelStyle: TextStyle(
                  color: focus.hasFocus ? Colors.purpleAccent : Colors.grey,
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.purpleAccent
                    )
                ),
                contentPadding:
                const EdgeInsets.fromLTRB(15.0, 20.0, 10.0, 25.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          ListTile(
            title: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchDetails(searchController.text.trim().replaceAll(" ", "+"))
                      ));
                },
                child: Text(
                  "Search",
                  style: TextStyle(color: Colors.white),
                ),
                height: 40.0,
                color: Colors.purpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )),
          )
        ],
      ),
    );
  }
}
