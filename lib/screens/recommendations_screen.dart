import 'package:agri_hack/constants.dart';
import 'package:agri_hack/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/measures.dart';

class ScreenRecommendations extends StatefulWidget {
  ScreenRecommendations({
    super.key,
    required this.measures,
  });

  Measures measures;

  @override
  State<ScreenRecommendations> createState() => _ScreenRecommendationsState();
}

class _ScreenRecommendationsState extends State<ScreenRecommendations> {
  String? dropdownValue;
  Measures minValues = Measures();
  Measures maxValues = Measures();
  bool _isLoading = false;

  _getIdealParameters(String dropdownValue) async {
    final valueMap = await FirestoreServices().getIdealMeasures(dropdownValue);

    minValues = valueMap["min"]!;
    maxValues = valueMap["max"]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff121421),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 28.w, top: 40.w),
                child: Text("Recommendations 🤔",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 34.w,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 10.w,
              ),
              Center(
                child: SizedBox(
                  width: 250.w,
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue))),
                    value: dropdownValue,
                    hint: const Text(
                      'Choose the crop to grow 🌴',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 18.0, // can be changed, default: 24.0
                    iconEnabledColor: Colors.white,
                    focusColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    dropdownColor: Colors.black,
                    onChanged: (String? newValue) {
                      setState(() {
                        _isLoading = true;
                      });
                      if (newValue != null && newValue != '') {
                        _getIdealParameters(newValue);
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      }
                      setState(() {
                        _isLoading = false;
                      });
                    },
                    items: plantDropdownItems,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              dropdownValue != null
                  ? !_isLoading
                      ? Text("Stuff has arrived")
                      : const Center(
                          child: CircularProgressIndicator(),
                        )
                  : Center(
                      child: Column(
                        children: [
                          const Text(
                            "OR",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 10.w,
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                  "Get Suggestions for Current Conditions."))
                        ],
                      ),
                    )
            ],
          ),
        ));
  }
}
