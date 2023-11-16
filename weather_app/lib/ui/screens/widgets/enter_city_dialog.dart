import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:weather_app/core/utils/string_extension.dart';

class EnterCityDialog extends StatelessWidget {
  const EnterCityDialog(
      {super.key, required this.controller, required this.onSubmit});
  final TextEditingController controller;
  final Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.lightBlue[100],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Enter city name:',
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: controller,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              hintText: 'Type here...',
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (controller.text.isNullOrEmpty()) {
              EasyLoading.showError('Please enter!');
            } else {
              onSubmit();
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
