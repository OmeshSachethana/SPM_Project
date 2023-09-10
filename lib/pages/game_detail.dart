import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spm/pages/game_list.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailScreen extends StatefulWidget {
  final String imageURL;
  final String name;
  final String description;
  final String gameURL;
  DetailScreen({ required this.imageURL, required this.name, required this.description , required this.gameURL});
  @override
  _DetailScreenState createState() => _DetailScreenState();
}


class _DetailScreenState extends State<DetailScreen> {

    _launchurl() async {
    const url = "https://poki.com/en/g/bubble-shooter-lak?campaign=15380731809&adgroup=142450448362&extensionid=&targetid=kwd-1181976641&location=9069431&matchtype=e&network=g&device=c&devicemodel=&creative=619830915996&keyword=bubble%20shooter&placement=&target=&gclid=CjwKCAjwr_CnBhA0EiwAci5silgntM8ukVzzdS902Jm25mNjoazvoaBg-TXR0I5-24xhhFxsaVeekRoCyj0QAvD_BwE" ;
    if(await  canLaunchUrl(url as Uri))
    {
      await launchUrl(url as Uri);
    }
    else {
      throw "Could not launch url";
    }
  }

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
      body: SingleChildScrollView(
              child :Container(
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
                        children: <Widget> [
                          Container(
                            height: 100,
                            child: Row(
                              children: <Widget> [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget> [
                                    Text(widget.name, style: TextStyle(fontSize: 16 )),
                                    Text('Description & Instruction', style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w600))
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 200,
                            child: Wrap(
                              children: <Widget> [
                                Text(widget.description, style: TextStyle(fontSize: 18))
                              ],
                            ),
                          ),
                          Container(
                            height: 60,
                            width: double.infinity,
                            child: MaterialButton(
                              onPressed: () async {
                                setState(() {});
                                _launchurl();
                              }, 
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              color: Color.fromARGB(255, 28, 122, 47),
                              child: Text("Play" , style: TextStyle(color: Colors.white , fontSize: 18 , fontWeight: FontWeight.w600)),
                            ),
                            
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
      )

    );
  }
}
 