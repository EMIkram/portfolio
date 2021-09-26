import 'dart:html';

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
            Stack(
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
                // Row(
                //   children: [
                //     SizedBox(width: 100,),
                //     CircleAvatar(
                //       child: CircleAvatar(
                //         child: Image.asset('assets/images/dp.png'),
                //       ),
                //     )
                //   ],
                // )
              ],
            )
          ],
        ),
      ),
    );
  }
}
