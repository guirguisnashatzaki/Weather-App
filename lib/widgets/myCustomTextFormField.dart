import 'package:flutter/material.dart';

class myCustomTextFormField extends StatelessWidget {
  myCustomTextFormField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            prefixIcon: const Icon(Icons.location_city),
            label: const Text("Desired City"),
            labelStyle: const TextStyle(
                color: Colors.grey
            ),
          ),
          textInputAction: TextInputAction.next,
          controller: controller,
        ),
      ),
    );
  }
}