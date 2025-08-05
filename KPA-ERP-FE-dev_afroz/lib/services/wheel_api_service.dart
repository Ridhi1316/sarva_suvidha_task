// lib/services/wheel_api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class WheelApiService {
  final String baseUrl = "http://127.0.0.1:8000/api/forms";

  // POST - Submit Form
Future<bool> submitWheelForm(Map<String, dynamic> payload) async {
  final response = await http.post(
    Uri.parse("http://127.0.0.1:8000/api/forms/wheel-specifications"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(payload),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    return true;
  } else {
    debugPrint("Error: ${response.body}");
    return false;
  }
}

  // GET - Fetch Wheel Specs
Future<List<WheelModel>> fetchWheelForms({String? formNumber, String? submittedBy, String? submittedDate}) async {
  final uri = Uri.http("http://127.0.0.1:8000", "/api/forms/wheel-specifications", {
    if (formNumber != null) 'formNumber': formNumber,
    if (submittedBy != null) 'submittedBy': submittedBy,
    if (submittedDate != null) 'submittedDate': submittedDate,
  });

  final response = await http.get(uri);
  if (response.statusCode == 200) {
    return (jsonDecode(response.body)['data'] as List)
        .map((item) => WheelModel.fromJson(item))
        .toList();
  } else {
    throw Exception("Failed to fetch");
  }
}
}
