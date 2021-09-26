import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(width);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(context),
          ],
        ),
      ),
    );
  }

  Widget header(BuildContext context){
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          width: width,
          height: 350,
          child: Image.asset("assets/images/portfolio_header.png",
            fit: BoxFit.cover,),
        ),
        Container(
          width: width,
          height: 350,
          color: Colors.black38,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(360.0),
                child: Image.asset(
                  "assets/images/dp.png",
                  height: 150.0,
                  width: 150.0,
                ),
              ),
            ),
            SizedBox(width: 70,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hi, I am Muhammad Ikram Ulhaq",style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w500
                ),),
                Text("Flutter Developer",style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                ),),
              ],
            ),
          ],
        )

      ],
    );
  }
  Widget body(){
    return Column(
      children: [
        Text("")
      ],
    );
  }
}
