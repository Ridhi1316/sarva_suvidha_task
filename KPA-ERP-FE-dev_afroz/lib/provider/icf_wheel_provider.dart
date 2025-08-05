import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class IcfWheelProvider extends ChangeNotifier {
  bool submitted = false;
  bool isEditing = false;
  bool showSummaryCard = false;
  bool showFilterCard = false;  // for filter summary card
  List<Map<String, dynamic>> filteredForms = [];

  final String apiBaseUrl = "http://127.0.0.1:8000/api/forms/wheel-specifications";

  final searchController = TextEditingController();
  final treadDiameterController = TextEditingController(text: "915 (900-1000)");
  final lastShopIssueController = TextEditingController(text: "837 (800-900)");
  final condemningDiaController = TextEditingController(text: "825 (800-900)");
  final wheelGaugeController = TextEditingController(text: "1600 (+2,-1)");
  final variationSameAxleController = TextEditingController(text: "0.5");
  final variationSameBogieController = TextEditingController(text: "5");
  final variationSameCoachController = TextEditingController(text: "13");
  final wheelProfileController = TextEditingController(text: "29.4 Flange Thickness");
  final intermediateWWPController = TextEditingController(text: "20 TO 28");
  final bearingSeatDiaController = TextEditingController(text: "130.043 TO 130.068");
  final rollerBearingOuterDiaController = TextEditingController(text: "280 (+0.0/-0.035)");
  final rollerBearingBoreDiaController = TextEditingController(text: "130 (+0.0/-0.025)");
  final rollerBearingWidthController = TextEditingController(text: "93 (+0/-0.250)");
  final axleBoxHousingBoreDiaController = TextEditingController(text: "280 (+0.030/+0.052)");
  final wheelDiscWidthController = TextEditingController(text: "127 (+4/-0)");


  final List<Map<String, Widget>> allFields = [];
  List<Map<String, Widget>> visibleFields = [];

  String filterFormNumber = '';
  String filterCreatedAt = '';
  String filterCreatedBy = '';

  bool get isFilterApplied => filterFormNumber.isNotEmpty || filterCreatedBy.isNotEmpty || filterCreatedAt.isNotEmpty;

  String generateFormNumber() {
    final now = DateTime.now();
    final year = now.year;
    final randomPart = DateTime.now().millisecondsSinceEpoch % 1000; // simple increment base
    return 'WHEEL-$year-${randomPart.toString().padLeft(3, '0')}';
  }

  void initializeFields(List<Map<String, Widget>> fields) {
    allFields.clear();
    allFields.addAll(fields);
    visibleFields = List.from(allFields);
    notifyListeners();
  }

  void filterFields(String query) {
    visibleFields = query.isEmpty
        ? List.from(allFields)
        : allFields
            .where((field) => field.keys.first.toLowerCase().contains(query.toLowerCase()))
            .toList();
    notifyListeners();
  }

  void applyFilter({String formNumber = '', String createdAt = '', String createdBy = ''}) {
    filterFormNumber = formNumber;
    filterCreatedAt = createdAt;
    filterCreatedBy = createdBy;
    showSummaryCard = false;
    notifyListeners();
  }

  Future<void> handleSubmit(BuildContext context) async {
    final formNumber = generateFormNumber();
    final currentUser = FirebaseAuth.instance.currentUser;
    final submittedBy = currentUser?.uid ?? "anonymous";
    final payload = {
      "form_number": formNumber,
      "submitted_by": submittedBy,
      "submitted_date": DateTime.now().toIso8601String().split('T')[0],
      "fields": {
        "tread_diameter_new": treadDiameterController.text,
        "last_shop_issue_size": lastShopIssueController.text,
        "condemning_dia": condemningDiaController.text,
        "wheel_gauge": wheelGaugeController.text,
        "variation_same_axle": variationSameAxleController.text,
        "variation_same_bogie": variationSameBogieController.text,
        "variation_same_coach": variationSameCoachController.text,
        "wheel_profile": wheelProfileController.text,
        "intermediate_wwp": intermediateWWPController.text,
        "bearing_seat_diameter": bearingSeatDiaController.text,
        "roller_bearing_outer_dia": rollerBearingOuterDiaController.text,
        "roller_bearing_bore_dia": rollerBearingBoreDiaController.text,
        "roller_bearing_width": rollerBearingWidthController.text,
        "axle_box_housing_bore_dia": axleBoxHousingBoreDiaController.text,
        "wheel_disc_width": wheelDiscWidthController.text,
      }
    };

    try {
      final response = await http.post(
        Uri.parse(apiBaseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        submitted = true;
        isEditing = false;
        showSummaryCard = true;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Submitted successfully.")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error occurred: $e")),
      );
    }
  }

  Future<void> fetchFilteredForms() async {
    final uri = Uri.parse(apiBaseUrl).replace(queryParameters: {
      if (filterFormNumber.isNotEmpty) 'formNumber': filterFormNumber,
      if (filterCreatedBy.isNotEmpty) 'submittedBy': filterCreatedBy,
      if (filterCreatedAt.isNotEmpty) 'submittedDate': filterCreatedAt,
    });

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData is Map<String, dynamic> && jsonData['data'] is List) {
          filteredForms = List<Map<String, dynamic>>.from(jsonData['data']);
        } else {
          filteredForms = [];
        }
      } else {
        filteredForms = [];
        debugPrint("Failed to fetch: ${response.body}");
      }
    } catch (e) {
      filteredForms = [];
      debugPrint("Error fetching filtered forms: $e");
    }

    visibleFields.clear();
    notifyListeners();
  }

  void handleEdit() {
    isEditing = true;
    notifyListeners();
  }
}
