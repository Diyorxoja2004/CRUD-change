import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  final String name;
  final String text;
  final void Function()? onPressed;
  const Box({super.key, required this.name, required this.text,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
        margin: const EdgeInsets.only(left: 20,bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(name),
      
                IconButton(
                  onPressed: onPressed, 
                  icon: const Icon(Icons.settings,color: Colors.black,)
                )
              ],
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}