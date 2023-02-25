import 'package:agri_hack/models/measures.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, Measures>> getIdealMeasures(String crop) async {
    Measures _minMeasures = Measures();
    Measures _maxMeasures = Measures();
    try {
      var response = await _firestore
          .collection("crop")
          .where("name", isEqualTo: crop)
          .get();
      var data = response.docs.first.data();
      if (data.isNotEmpty) {
        _minMeasures.n = data["N"][0].toDouble();
        _maxMeasures.n = data["N"][1].toDouble();
        _minMeasures.p = data["P"][0].toDouble();
        _maxMeasures.p = data["P"][1].toDouble();
        _minMeasures.k = data["K"][0].toDouble();
        _maxMeasures.k = data["K"][1].toDouble();
        _minMeasures.temperature = data["temp"][0].toDouble();
        _maxMeasures.temperature = data["temp"][1].toDouble();
        _minMeasures.pH = data["pH"][0].toDouble();
        _maxMeasures.pH = data["pH"][1].toDouble();
        _minMeasures.moisture = data["moisture"][0].toDouble();
        _maxMeasures.moisture = data["moisture"][1].toDouble();
      }
      print(response);
    } catch (e) {
      print("An exception occured: $e");
    }
    return {"min": _minMeasures, "max": _maxMeasures};
  }
}
