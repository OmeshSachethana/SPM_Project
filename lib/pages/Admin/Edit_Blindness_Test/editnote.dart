import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spm/pages/Admin/Edit_Blindness_Test/edit_blindness.dart';

import 'report.dart';

class editnote extends StatefulWidget {
  DocumentSnapshot docid;
  editnote({required this.docid});

  @override
  _editnoteState createState() => _editnoteState(docid: docid);
}

class _editnoteState extends State<editnote> {
  DocumentSnapshot docid;
  _editnoteState({required this.docid});
  TextEditingController name = TextEditingController();
  TextEditingController subject1 = TextEditingController();
  TextEditingController subject2 = TextEditingController();
  TextEditingController subject3 = TextEditingController();

  @override
  void initState() {
    name = TextEditingController(text: widget.docid.get('name'));
    subject1 = TextEditingController(text: widget.docid.get('Maths'));
    subject2 = TextEditingController(text: widget.docid.get('Science'));
    subject3 = TextEditingController(text: widget.docid.get('History'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => reportDispllay()));
            },
            child: Text(
              "Back",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              widget.docid.reference.update({
                'name': name.text,
                'Maths': subject1.text,
                'Science': subject2.text,
                'History': subject3.text
              }).whenComplete(() {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => reportDispllay()));
              });
            },
            child: Text(
              "save",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => reportDispllay()));
              });
            },
            child: Text(
              "delete",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
        ],
      ),

      //--------------------------------------------------
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                    hintText: 'Color Blindness Report Name',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: subject1,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Test 1',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: subject2,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Test 2',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: subject3,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Test 3',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              //make reoport button -------------------------------------------
              MaterialButton(
                color: Colors.green,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => reportt(
                        docid: docid,
                      ),
                    ),
                  );
                },
                child: Text(
                  "Genearate Report",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 251, 251, 251),
                  ),
                ),
              ),

              //-------------------------------------------
            ],
          ),
        ),
      ),
    );
  }
}
