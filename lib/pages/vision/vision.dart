import 'package:flutter/material.dart';
import '../../services/api_services.dart';
import 'resultVision.dart';

class Vision extends StatefulWidget {
  const Vision({Key? key}) : super(key: key);

  @override
  State<Vision> createState() => _VisionState();
}

class _VisionState extends State<Vision> {
  final MyApiService apiService = MyApiService();
  late Future<List<String>> imageUrlFuture;
  int currentIndex = 0;
  TextEditingController textAnswerController = TextEditingController();

  int correctAnswers = 0;
  List<String> userAnswers = [];
  // hard code image values
  List<String> correctTextAnswers = [
    "A",
    "E",
    "Z",
  ];
  @override
  void initState() {
    super.initState();

    imageUrlFuture = apiService.getImageUrlsVision();
  }

  // next image
  void goToNextImage() {
    setState(() {
      if (currentIndex < userAnswers.length) {
        userAnswers[currentIndex] = textAnswerController.text;
      } else {
        userAnswers.add(textAnswerController.text);
      }
      currentIndex++;
      textAnswerController.clear();
    });
    if (currentIndex >= correctTextAnswers.length) {
      navigateToResultPage();
    }

    //print(userAnswers);
  }

  // calculate presentage

  double calculatePercentage(
      List<String> userAnswers, List<String> correctTextAnswers) {
    if (userAnswers.isEmpty || correctTextAnswers.isEmpty) {
      return 0.0;
    }

    int correctCount = 0;

    for (int i = 0; i < userAnswers.length; i++) {
      if (i < correctTextAnswers.length &&
          userAnswers[i] == correctTextAnswers[i]) {
        correctCount++;
      }
    }

    double percentage = (correctCount / userAnswers.length) * 100;

    return percentage;
  }

  void navigateToResultPage() {
    double percentage = calculatePercentage(userAnswers, correctTextAnswers);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultVision(percentage: percentage),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 28, 122, 47),
          title: const Text('Vision problem Testing'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              FutureBuilder<List<String>>(
                future: imageUrlFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData ||
                      currentIndex >= snapshot.data!.length) {
                    return const SizedBox();
                  } else {
                    // Display the image using the NetworkImage.
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 300,
                          height: 300,
                          child: Image(
                            image: NetworkImage(snapshot.data![currentIndex]),
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: textAnswerController,
                            decoration: const InputDecoration(
                              labelText: 'Enter Your Answer',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //SizedBox(width: 20),

                            ElevatedButton(
                              onPressed: goToNextImage,
                              child: const Text('Next'),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
