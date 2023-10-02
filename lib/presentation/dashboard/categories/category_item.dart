import 'package:flutter/material.dart';
import 'package:quiz_bloc/utility/category_detail_list.dart';

import '../../main/prepare_quiz_screen.dart';

class CategoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PrepareQuizScreen()));
        },
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                // color: Colors.grey.shade50,
                color: categoryDetailList[0].accentColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    categoryDetailList[0].title,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
