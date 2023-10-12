import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:spm/pages/create_game.dart';
import 'package:spm/pages/game_details.dart';

class UserGameList extends StatefulWidget {

  UserGameList({Key? key}): super(key: key);
  @override
  State<UserGameList> createState() => _UserGameListState();
}

class _UserGameListState extends State<UserGameList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 28, 122, 47),
        centerTitle: true,
        title: Text(
          'List of Games',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('games').snapshots(),
        builder: (BuildContext context,
         AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          return streamSnapshot.hasData
          ? ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: ((context, index){
              return Container(
                margin: EdgeInsets.symmetric(vertical: 10)
                  .copyWith(bottom: 3),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: 
                  BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(2,2)
                    )
                  ],borderRadius:BorderRadius.all(Radius.circular(10.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(streamSnapshot.data!.docs[index]['imageURL'])
                          ),
                          SizedBox(width: 11),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                streamSnapshot.data!.docs[index]['name'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
    
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                    DetailScreen(
                                      name: streamSnapshot.data!
                                        .docs[index]['name'],
                                      description: streamSnapshot.data!
                                        .docs[index]['description'],
                                      gameURL: streamSnapshot.data!
                                        .docs[index]['gameURL'],
                                      imageURL: streamSnapshot.data!
                                        .docs[index]['imageURL'],
                                      id: streamSnapshot.data!
                                        .docs[index]['id'],
                                      clicks: streamSnapshot.data!
                                        .docs[index]['clicks'],
                                      docid: streamSnapshot.data!.docs[index],
                                  )
                                )
                              );
                            },

                            child: Icon(
                              Icons.remove_red_eye,
                              color: Colors.blue,
                              size: 21,
                            ),
                          ),
                      ],
                      ),
                    ],
                  ));
         }))
         : Center(
          child: SizedBox(
            height: 100,
            width: 100,
            child: CircularProgressIndicator()
          ),
         );
         },
      ),
    );
  }
}
