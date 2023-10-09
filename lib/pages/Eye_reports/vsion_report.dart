import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spm/services/api_services.dart';

class VisionResultViewPage extends StatefulWidget {


  const VisionResultViewPage({super.key});

  @override
  _VisionResultViewPageState createState() => _VisionResultViewPageState();
}

class _VisionResultViewPageState extends State<VisionResultViewPage> {
  late List<Map<String, dynamic>> userResults=[];
  final user = FirebaseAuth.instance.currentUser;
  MyApiService apiService = MyApiService();


  @override
  void initState() {
    super.initState();
    _loadUserResults();
  }

  Future<void> _loadUserResults() async {
    String? userUid = user?.uid;
    List<Map<String, dynamic>> results = await apiService.getUserVisionResultsFromFirebase(userUid!) ;
    setState(() {
      userResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blindness User Results'),
        backgroundColor: Colors.green,
      ),
      body: userResults == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: userResults.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> result = userResults[index];
          return ListTile(
            title: Text('Percentage: ${result['percentage']}'),
            subtitle: Text('Date: ${result['date']}'),
          );
        },
      ),
    );
  }
}


