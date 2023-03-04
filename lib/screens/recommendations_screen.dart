// ignore_for_file: use_build_context_synchronously

import 'package:agri_hack/constants.dart';
import 'package:agri_hack/services/firestore_services.dart';
import 'package:agri_hack/services/prediction_service.dart';
import 'package:agri_hack/services/recommendations_system.dart';
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
  bool _isLoadingFlask = false;
  String prediction = "";

  _predictCrops() async {
    setState(() {
      _isLoadingFlask = true;
    });
    print("Getting Data");
    prediction = await PredictionService.predict(
        widget.measures.n,
        widget.measures.p,
        widget.measures.k,
        widget.measures.temperature,
        widget.measures.moisture,
        widget.measures.pH,
        100.0 //dummy,
        );

    setState(() {
      _isLoadingFlask = false;
    });
    showDialog(
        context: context,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(12.0)), //this right here
              backgroundColor: Colors.black87,
              child: SizedBox(
                height: 300.0,
                width: 300.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 15.h),
                      child: Text(
                        prediction.toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.w),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Text(
                        'This crop is best suited for your conditions',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'OK 👍',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ))
                  ],
                ),
              ),
            ));
  }

  _getIdealParameters(String dropdownValue) async {
    setState(() {
      _isLoading = true;
    });
    final valueMap = await FirestoreServices().getIdealMeasures(dropdownValue);

    setState(() {
      minValues = valueMap["min"]!;
      maxValues = valueMap["max"]!;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff121421),
        appBar: AppBar(
          backgroundColor: const Color(0xff121421),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 28.w),
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
                            dropdownValue = newValue;
                          });
                        }
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
                        ? Column(
                            children: [
                              RecommendationSystem(
                                  currentMeasures: widget.measures,
                                  minMeasures: minValues,
                                  maxMeasures: maxValues),
                              Text(
                                "For more details, contact your nearest Krishibhavan",
                                style: const TextStyle(color: Colors.white),
                              )
                            ],
                          )
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
                                onPressed: () {
                                  _predictCrops();
                                },
                                child: _isLoadingFlask
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        "Get Suggestions for Current Conditions."))
                          ],
                        ),
                      )
              ],
            ),
          ),
        ));
  }
}
