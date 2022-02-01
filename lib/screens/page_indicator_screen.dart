
import 'package:custom_widgets/custom_widgets/page_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageIndicatorScreen extends StatefulWidget {
  const PageIndicatorScreen({Key? key}) : super(key: key);

  @override
  _PageIndicatorScreenState createState() => _PageIndicatorScreenState();
}

class _PageIndicatorScreenState extends State<PageIndicatorScreen> {

  double itemCount = 10;
  int currentIndex = 1;

  currentIndexCallBack(int currentIndex){
    setState(() {
      this.currentIndex = currentIndex;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Current index is: $currentIndex",
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          PageIndicator(
              itemCount: itemCount,
              currentIndexCallBack: currentIndexCallBack
          ),
        ],
      )
    );
  }
}
