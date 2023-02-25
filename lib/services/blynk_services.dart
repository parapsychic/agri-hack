import 'package:agri_hack/API_KEY.dart';
import 'package:agri_hack/models/measures.dart';
import 'package:dio/dio.dart';

class BlynkServices {
  static const API_URL = "https://blynk.cloud/external/api/get?token=";

  static Future<ServerReturns> getValues() async {
    print("Inside REST Service");
    Measures _measures = Measures();
    StatusCode status = StatusCode.EXECUTION;

    // the last element shows if the call was successful
    // use try catch and if some exception occurs, return a 0 arr
    // And show a snackbar using the status
    try {
      // pull stuff using dio
      // TODO iterate till <=3, ie 4
      final _list = [0.0, 0.0, 0.0, 0.0];
      for (int pin = 0; pin < 3; pin++) {
        final response = await Dio().get("$API_URL$API_TOKEN&v$pin");
        print("DATA : ${response.data}");
        double val = response.data.toDouble();
        _list[pin] = val;
      }
      // TODO name this according to pin, or do a map in constants
      // TODO i have doubts with NPK, so I'm going to give garbage
      _measures = Measures(
        n: _list[0],
        p: 0.0,
        k: 0.0,
        moisture: _list[1],
        temperature: _list[2],
        pH: _list[3],
      );
      status = StatusCode.SUCCESS;
      print("SUCCESS");
    } catch (e) {
      status = StatusCode.FAILURE;
      print("FAILED: $e");
    }
    return ServerReturns(status: status, measures: _measures);
  }

  static Future<List> getSingleValue(int pin) async {
    print("Inside REST Service");
    StatusCode status = StatusCode.EXECUTION;
    double value = 0.0;
    try {
      final response = await Dio().get("$API_URL$API_TOKEN&v$pin");
      print("DATA : ${response.data}");
      value = response.data.toDouble();
      // TODO name this according to pin, or do a map in constants
      // TODO i have doubts with NPK, so I'm going to give garbage

      status = StatusCode.SUCCESS;
      print("SUCCESS");
    } catch (e) {
      status = StatusCode.FAILURE;
      print("FAILED: $e");
    }
    return [status, value];
  }
}

enum StatusCode {
  SUCCESS,
  FAILURE,
  EXECUTION,
}

class ServerReturns {
  StatusCode status;
  Measures measures;

  ServerReturns({required this.status, required this.measures});
}
