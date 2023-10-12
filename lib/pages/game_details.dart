import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spm/pages/SinngleGameReport.dart';
import 'package:spm/pages/game_list.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  final String imageURL;
  final String name;
  final String description;
  final String gameURL;
  final String id;
  final int clicks;
  DocumentSnapshot docid;
  final user = FirebaseAuth.instance.currentUser!;

  DetailScreen(
      {required this.imageURL,
      required this.name,
      required this.description,
      required this.gameURL,
      required this.id,
      required this.clicks,
      required this.docid});
  @override
  _DetailScreenState createState() => _DetailScreenState(docid: docid);
}

class _DetailScreenState extends State<DetailScreen> {
  DocumentSnapshot docid;
  _DetailScreenState({required this.docid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 28, 122, 47),
          centerTitle: true,
          title: Text(
            'Game Details',
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
        ),
        body: Container(
          color: Colors.green[100],
          child: SingleChildScrollView(
              child: Container(
            child: Column(
              children: <Widget>[
                Center(
                  child: Card(
                    child: Container(
                      width: 350,
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(13),
                          child: Container(
                            height: 220,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(widget.imageURL),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        child: Row(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(widget.name,
                                    style: TextStyle(fontSize: 16)),
                                Text('Description & Instruction',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        child: Wrap(
                          children: <Widget>[
                            Text(widget.description,
                                style: TextStyle(fontSize: 18))
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        width: double.infinity,
                        child: MaterialButton(
                          onPressed: () async {
                            setState(() {});
                            // ignore: deprecated_member_use
                            launch(widget.gameURL);

                            final dUser = FirebaseFirestore.instance
                                .collection('games')
                                .doc(widget.id.isNotEmpty ? widget.id : null);

                            final jsonData = {
                              'name': widget.name,
                              'description': widget.description,
                              'gameURL': widget.gameURL,
                              'imageURL': widget.imageURL,
                              'id': widget.id,
                              'clicks': widget.clicks + 1
                            };

                            await dUser.update(jsonData);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Color.fromARGB(255, 28, 122, 47),
                          child: Text("Play",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                      Container(
                        height: 20,
                      ),
                      Container(
                        height: 60,
                        width: double.infinity,
                        child: MaterialButton(
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => GameReport(
                                  docid: docid,
                                ),
                              ),
                            );
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.red.shade400,
                          child: Text("Generate Report",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
        ));
  }
}
