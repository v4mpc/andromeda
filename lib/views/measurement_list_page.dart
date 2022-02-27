import 'package:flutter/material.dart';

class MeasurementListPage extends StatefulWidget {
  const MeasurementListPage({Key? key}) : super(key: key);

  @override
  State<MeasurementListPage> createState() => _MeasurementListPageState();
}

class _MeasurementListPageState extends State<MeasurementListPage> {
  int selectedItems = 0;
  List myList = [
    {
      'weight': {'id': 5, 'value': '70 Kg', 'selected': false},
      'height': {'id': 5, 'value': '710 Cm', 'selected': false},
      'bmi': {'id': 5, 'value': '12 bmi', 'selected': false},
      'selected': false,
      'date': '2022-04-04'
    },
    {
      'weight': {'id': 5, 'value': '70 Kg', 'selected': false},
      'height': {'id': 5, 'value': '710 Cm', 'selected': false},
      'bmi': {'id': 5, 'value': '12 bmi', 'selected': false},
      'selected': false
    },
    {
      'weight': {'id': 5, 'value': '70 Kg', 'selected': false},
      'height': {'id': 5, 'value': '710 Cm', 'selected': false},
      'bmi': {'id': 5, 'value': '12 bmi', 'selected': false},
      'selected': false
    },
    {
      'weight': {'id': 5, 'value': '70 Kg', 'selected': false},
      'height': {'id': 5, 'value': '710 Cm', 'selected': false},
      'bmi': {'id': 5, 'value': '12 bmi', 'selected': false},
      'selected': false
    },
    {
      'weight': {'id': 5, 'value': '70 Kg', 'selected': false},
      'height': {'id': 5, 'value': '710 Cm', 'selected': false},
      'bmi': {'id': 5, 'value': '12 bmi', 'selected': false},
      'selected': false
    },
    {
      'weight': {'id': 5, 'value': '70 Kg', 'selected': false},
      'height': {'id': 5, 'value': '710 Cm', 'selected': false},
      'bmi': {'id': 5, 'value': '12 bmi', 'selected': false},
      'selected': false
    },
    {
      'weight': {'id': 5, 'value': '70 Kg', 'selected': false},
      'height': {'id': 5, 'value': '710 Cm', 'selected': false},
      'bmi': {'id': 5, 'value': '12 bmi', 'selected': false},
      'selected': false
    },
    {
      'weight': {'id': 5, 'value': '70 Kg', 'selected': false},
      'height': {'id': 5, 'value': '710 Cm', 'selected': false},
      'bmi': {'id': 5, 'value': '12 bmi', 'selected': false},
      'selected': false
    },
  ];



  set selectedStated(bool value){
    for (var m in myList) {
      m['selected']=value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: Checkbox(
          value: selectedItems >= myList.length,
          onChanged: (bool? value) {
            if (value ?? false) {
              selectedItems = myList.length;
              selectedStated=true;
            } else {
              selectedItems = 0;
              selectedStated=false;
            }
            setState(() {});
          },
        ),
        title: selectedItems <= 0
            ? const Text('Measurements')
            : Text('$selectedItems Selected'),
        actions: [
          if (selectedItems > 0)
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Increase volume by 10',
              onPressed: () {

              },
            )
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: myList.length,
          itemBuilder: (context, index) {
            return _buildCheckboxListTile(context, index);
          },
        ),
      ),
    );
  }


  Widget _buildListTile(BuildContext context, int index) {
    return GestureDetector(
      onLongPress:(){
        setState(() {
          myList[index]['selected']=true;
          ++selectedItems;
        });
      } ,
      child: ListTile(
        title: RichText(
          text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(text: myList[index]['weight']['value']),
                TextSpan(text: ' / '),
                TextSpan(text: myList[index]['height']['value']),
                TextSpan(text: ' / '),
                TextSpan(text: myList[index]['bmi']['value'])
              ]),
        ),
        subtitle: Text('26 Feb 2021'),

      ),
    );
  }

  Widget _buildCheckboxListTile(BuildContext context, int index) {
    return CheckboxListTile(
            title: RichText(
              text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(text: '${myList[index]['weight']['value']} / '),
                    TextSpan(text: '${myList[index]['height']['value']} / '),
                    TextSpan(text: myList[index]['bmi']['value'])
                  ]),
            ),
            subtitle: Text('26 Feb 2021'),
            // tileColor: Colors.green,
            value: myList[index]['selected'],
            onChanged: (bool? value) {
              setState(() {
                bool _itemSelection = value ?? false;
                myList[index]['selected'] = _itemSelection;
                if (_itemSelection) {
                  ++selectedItems;
                } else {
                  --selectedItems;
                }
              });
              assert(selectedItems < 0);
              assert(selectedItems > myList.length);
            },
            secondary: const Icon(Icons.square_foot_outlined),
            controlAffinity: ListTileControlAffinity.leading,
          );
  }
}
