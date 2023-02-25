import 'package:agri_hack/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../widgets/textforminput.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => ScreenLoginState();
}

class ScreenLoginState extends State<ScreenLogin> {
  final TextEditingController _phoneController = TextEditingController();

  bool _isLoading = false;

  _loginUser() {}

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          TextFormInput(
            textEditingController: _phoneController,
            prefix: const Padding(
              padding: EdgeInsets.all(4),
              child: Text(
                "+91",
              ),
            ),
            hintText: "Phone",
            textInputType: TextInputType.number,
            isNumber: true,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: _loginUser,
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text("Login"),
          ),
        ],
      ),
    ));
  }
}
