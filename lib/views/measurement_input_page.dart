import 'package:andromeda/models/all_models.dart';
import 'package:andromeda/services/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MeasurementInputPage extends StatelessWidget {
  static const route = '/inputpage';
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  MeasurementInputPage({Key? key}) : super(key: key);

  String? _inputValidator(String? value, int maxNumber) {
    final RegExp regex = RegExp(r'^[0-9][0-9.]*$');
    if (value != null && !regex.hasMatch(value)) {
      return 'Only positive digits allowed';
    }

    final double dValue = double.parse(value ?? '0');
    if (value != null && (dValue > maxNumber || dValue < 1)) {
      return 'Allowed 1-$maxNumber';
    }
    return null;
  }

  String? _validateWeight(String? value, int maxNumber) {
    if (_heightController.text.isEmpty ||
        (_heightController.text.isNotEmpty &&
            _weightController.text.isNotEmpty)) {
      return _inputValidator(value, maxNumber);
    }
  }

  String? _validateHeight(String? value, int maxNumber) {
    if (_weightController.text.isEmpty ||
        (_weightController.text.isNotEmpty &&
            _heightController.text.isNotEmpty)) {
      return _inputValidator(value, maxNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Measurement Input'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(13.0),
            child: Column(
              children: [
                Text(
                  '* You can fill one or both fields.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: TextFormField(
                        controller: _weightController,
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.monitor_weight_outlined),
                          labelText: 'Weight (Kg)',
                        ),
                        validator: (String? value) =>
                            _validateWeight(value, 1000),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    // Expanded(
                    //   flex: 2,
                    //   child: DropdownButtonFormField<String>(
                    //     value: 'Kg',
                    //     icon: const Icon(Icons.expand_more),
                    //     // elevation: 16,
                    //     style: const TextStyle(color: Colors.deepPurple),
                    //     onChanged: (String? newValue) {},
                    //     items: <String>['Kg', 'Ounce']
                    //         .map<DropdownMenuItem<String>>((String value) {
                    //       return DropdownMenuItem<String>(
                    //         value: value,
                    //         child: Text(value),
                    //       );
                    //     }).toList(),
                    //   ),
                    // )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: TextFormField(
                        controller: _heightController,
                        keyboardType: TextInputType.number,
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.straighten),
                          labelText: 'Height (Cm)',
                        ),
                        validator: (String? value) =>
                            _validateHeight(value, 500),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    // Expanded(
                    //   flex: 2,
                    //   child: DropdownButtonFormField<String>(
                    //     value: 'Cm',
                    //     icon: const Icon(Icons.expand_more),
                    //     // elevation: 16,
                    //     style: const TextStyle(color: Colors.deepPurple),
                    //     onChanged: (String? newValue) {},
                    //     items: <String>['Cm', 'Ounce']
                    //         .map<DropdownMenuItem<String>>((String value) {
                    //       return DropdownMenuItem<String>(
                    //         value: value,
                    //         child: Text(value),
                    //       );
                    //     }).toList(),
                    //   ),
                    // )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // FocusManager.instance.primaryFocus?.unfocus();
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffE0F2F1),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final form = _formKey.currentState;
                          if (!form!.validate()) {
                            print('invalid form');
                            return;
                          }

                          List<FormData> formData = [];
                          if (_weightController.text.isNotEmpty) {
                            formData.add(
                              FormData.fromMap({
                                'date': '2022-2-11',
                                'typeId': 1,
                                'unitId': 1,
                                'value': double.parse(_weightController.text)
                              }),
                            );
                          }

                          if (_heightController.text.isNotEmpty) {
                            formData.add(
                              FormData.fromMap({
                                'date': '2022-2-11',
                                'typeId': 2,
                                'unitId': 2,
                                'value': double.parse(_heightController.text)
                              }),
                            );
                          }
                          // clear validators on input

                          await Provider.of<AppService>(context, listen: false)
                              .saveMeasurements(formData);
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor),
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
                // Row()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
