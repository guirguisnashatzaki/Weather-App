import 'package:flutter/material.dart';

class myButton extends StatelessWidget {
  String text;
  Function() fun;
  myButton({Key? key,required this.text,required this.fun}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20)
        ),
        width: MediaQuery.of(context).size.width,
        child: Text(text,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
      ),
    );
  }
}