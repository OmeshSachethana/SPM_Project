import 'package:flutter/material.dart';
import '../../services/api_services.dart';
import 'custom_button.dart';
import '../bilndness/blindness.dart';
import '../vision/vision.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
final MyApiService apiService = MyApiService();



class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),

        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              CustomButton(
                imageUrl: 'assets/eye_logo.png',
                buttonName: 'Vision Problem Detection',
                onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (_) => const Vision()  ));

                },
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                imageUrl: 'assets/blind.jpg',
                buttonName: 'Color Blindness Detection',
                onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (_) => const Blindness()  ));

                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
