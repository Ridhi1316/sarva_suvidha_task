import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:kpa_erp/provider/icf_wheel_provider.dart';
import 'package:kpa_erp/widgets/custom_dropdown.dart';
import 'package:kpa_erp/widgets/custom_text_field.dart';
import 'package:kpa_erp/widgets/custom_search_bar.dart';
import 'package:provider/provider.dart';

class IcfWheel extends StatelessWidget {
  const IcfWheel({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IcfWheelProvider(),
      child: const IcfWheelView(),
    );
  }
}

class IcfWheelView extends StatefulWidget {
  const IcfWheelView({super.key});

  @override
  State<IcfWheelView> createState() => _IcfWheelViewState();
}

class _IcfWheelViewState extends State<IcfWheelView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<IcfWheelProvider>(context, listen: false);
      provider.initializeFields(_buildFields(provider));
    });
  }

  List<Map<String, Widget>> _buildFields(IcfWheelProvider p) {
    const sectionSpacing = SizedBox(height: 10);

    return [
      {
        "Tread Diameter (New)": CustomTextField(
          label: "Tread Diameter (New)",
          value: p.treadDiameterController.text,
          controller: p.treadDiameterController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
      },
      {"section": sectionSpacing},
      {
        "Last Shop Issue Size (Dia.)": CustomTextField(
          label: "Last Shop Issue Size (Dia.)",
          value: p.lastShopIssueController.text,
          controller: p.lastShopIssueController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
      },
      {"section": sectionSpacing},
      {
        "Condemning Dia.": CustomTextField(
          label: "Condemning Dia.",
          value: p.condemningDiaController.text,
          controller: p.condemningDiaController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
      },
      {"section": sectionSpacing},
      {
        "Wheel Gauge (IFD)": CustomTextField(
          label: "Wheel Gauge (IFD)",
          value: p.wheelGaugeController.text,
          controller: p.wheelGaugeController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
      },
      {"section": sectionSpacing},
      {
        "Variation on Same Axle": CustomTextField(
          label: "Variation on Same Axle",
          value: p.variationSameAxleController.text,
          controller: p.variationSameAxleController,
        ),
      },
      {"section": sectionSpacing},
      {
        "Wheel Profile": CustomTextField(
          label: "Wheel Profile",
          value: p.wheelProfileController.text,
          controller: p.wheelProfileController,
        ),
      },
      {"section": sectionSpacing},
      {
        "Intermediate WWP": CustomTextField(
          label: "Intermediate WWP",
          value: p.intermediateWWPController.text,
          controller: p.intermediateWWPController,
        ),
      },
      {"section": sectionSpacing},
      {
        "Bearing Seat Diameter": CustomTextField(
          label: "Bearing Seat Diameter",
          value: p.bearingSeatDiaController.text,
          controller: p.bearingSeatDiaController,
        ),
      },
      {"section": sectionSpacing},
      {
        "Roller Bearing Outer Dia": CustomTextField(
          label: "Roller Bearing Outer Dia",
          value: p.rollerBearingOuterDiaController.text,
          controller: p.rollerBearingOuterDiaController,
        ),
      },
      {"section": sectionSpacing},
      {
        "Roller Bearing Bore Dia": CustomTextField(
          label: "Roller Bearing Bore Dia",
          value: p.rollerBearingBoreDiaController.text,
          controller: p.rollerBearingBoreDiaController,
        ),
      },
      {"section": sectionSpacing},
      {
        "Roller Bearing Width": CustomTextField(
          label: "Roller Bearing Width",
          value: p.rollerBearingWidthController.text,
          controller: p.rollerBearingWidthController,
        ),
      },
      {"section": sectionSpacing},
      {
        "Axle Box Housing Bore Dia": CustomTextField(
          label: "Axle Box Housing Bore Dia",
          value: p.axleBoxHousingBoreDiaController.text,
          controller: p.axleBoxHousingBoreDiaController,
        ),
      },
      {"section": sectionSpacing},
      {
        "Wheel Disc Width": CustomTextField(
          label: "Wheel Disc Width",
          value: p.wheelDiscWidthController.text,
          controller: p.wheelDiscWidthController,
        ),
      },
      {"section": sectionSpacing},
    ];
  }

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text("$label:", style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _summaryCard(IcfWheelProvider p) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 10),
                    Text("Submitted Data", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.indigo),
                  onPressed: p.handleEdit,
                ),
              ],
            ),
            const Divider(),
            _summaryRow("Tread Diameter", p.treadDiameterController.text),
            _summaryRow("Last Shop Issue Size (Dia.)", p.lastShopIssueController.text),
            _summaryRow("Condemning Dia.", p.condemningDiaController.text),
            _summaryRow("Wheel Gauge (IFD)", p.wheelGaugeController.text),
            _summaryRow("Wheel Profile", p.wheelProfileController.text),
            _summaryRow("Intermediate WWP", p.intermediateWWPController.text),
            _summaryRow("Bearing Seat Diameter", p.bearingSeatDiaController.text),
            _summaryRow("Roller Bearing Outer Dia", p.rollerBearingOuterDiaController.text),
            _summaryRow("Roller Bearing Bore Dia", p.rollerBearingBoreDiaController.text),
            _summaryRow("Roller Bearing Width", p.rollerBearingWidthController.text),
            _summaryRow("Axle Box Housing Bore Dia", p.axleBoxHousingBoreDiaController.text),
            _summaryRow("Wheel Disc Width", p.wheelDiscWidthController.text),

          ],
        ),
      ),
    );
  }

  Widget _filteredSummaryCard(Map<String, dynamic> item) {
    final fields = item['fields'] ?? {};
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Submitted Data", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            _summaryRow("Tread Diameter", fields['tread_diameter_new'] ?? "-"),
            _summaryRow("Last Shop Issue Size (Dia.)", fields['last_shop_issue_size'] ?? "-"),
            _summaryRow("Condemning Dia.", fields['condemning_dia'] ?? "-"),
            _summaryRow("Wheel Gauge (IFD)", fields['wheel_gauge'] ?? "-"),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context, IcfWheelProvider provider) {
    final formNumberController = TextEditingController();
    final createdAtController = TextEditingController();
    final createdByController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Filter Fields"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(label: 'Form Number', controller: formNumberController, value: ''),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    createdAtController.text = DateFormat('yyyy-MM-dd').format(picked);
                  }
                },
                child: AbsorbPointer(
                  child: CustomTextField(label: 'Created At', controller: createdAtController, value: ''),
                ),
              ),
              const SizedBox(height: 10),
              CustomTextField(label: 'Created By', controller: createdByController, value: ''),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Apply'),
              onPressed: () async {
                provider.applyFilter(
                  formNumber: formNumberController.text,
                  createdAt: createdAtController.text,
                  createdBy: createdByController.text,
                );
                await provider.fetchFilteredForms();
                provider.visibleFields.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<IcfWheelProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("ICF Wheel Specs"),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context, provider),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(
              controller: provider.searchController,
              onChanged: provider.filterFields,
              hintText: "Search fields...",
            ),
            const SizedBox(height: 20),
            if (provider.filteredForms.isNotEmpty) ...[
              const Text("Filtered Results", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ...provider.filteredForms.map((item) => _filteredSummaryCard(item)).toList(),
              const Divider(height: 30),
            ] else if (provider.showSummaryCard) ...[
              _summaryCard(provider),
            ],

            const SizedBox(height: 30),
            if (!provider.submitted && !provider.isFilterApplied)
              ...provider.visibleFields.map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: e.values.first,
                  )),

            if (!provider.submitted && !provider.isFilterApplied)
              ElevatedButton.icon(
                onPressed: () => provider.handleSubmit(context),
                icon: const Icon(Icons.check),
                label: const Text("Submit"),
              ),
          ],
        ),
      ),
    );
  }
}
