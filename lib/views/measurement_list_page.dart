import 'package:andromeda/services/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:andromeda/models/all_models.dart';

class MeasurementListPage extends StatefulWidget {
  List<MeasurementGroupedByDate> myList;

  MeasurementListPage({Key? key, required this.myList}) : super(key: key);

  @override
  State<MeasurementListPage> createState() => _MeasurementListPageState();
}

class _MeasurementListPageState extends State<MeasurementListPage> {
  int selectedItems = 0;

  set selectedStated(bool value) {
    for (var m in widget.myList) {
      m.selected = value;
    }
  }

  // @override
  // void initState(){
  //   super.initState();
  //   print('init state called');
  //   selectedItems=widget.myList.where((MeasurementGroupedByDate element) => element.selected==true).toList().length;
  // }

  @override
  Widget build(BuildContext context) {
    selectedItems=widget.myList.where((MeasurementGroupedByDate element) => element.selected==true).toList().length;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: Visibility(
          maintainSize: false,
          visible: widget.myList.isNotEmpty,
          child: Checkbox(
            value: selectedItems >= widget.myList.length &&
                widget.myList.isNotEmpty,
            onChanged: (bool? value) {
              if (value ?? false) {
                selectedItems = widget.myList.length;
                selectedStated = true;
              } else {
                selectedItems = 0;
                selectedStated = false;
              }
              setState(() {});
            },
          ),
        ),
        title: selectedItems <= 0
            ? const Text('Measurements')
            : Text('$selectedItems Selected'),
        actions: [
          if (selectedItems > 0)
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Delete selected item(s)',
              onPressed: () {
                Provider.of<AppService>(context,listen: false).deleteSelectedMeasurements(widget.myList);
                selectedItems=0;
              },
            )
        ],
      ),
      body: Container(
        child: widget.myList.isNotEmpty ? _buildListView() : Container(),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: widget.myList.length,
      itemBuilder: (context, index) {
        return _buildCheckboxListTile(context, index);
      },
    );
  }


  Widget _buildSubTitle(int index) {
    if(widget.myList[index].weight != null){
      return Text(widget.myList[index].weight!.date);
    }else if (widget.myList[index].height != null){
      return Text(widget.myList[index].height!.date);
    }else if(widget.myList[index].bmi != null){
      return Text(widget.myList[index].bmi!.date);
    }else{
      return const Text('');
    }

  }

  Widget _buildCheckboxListTile(BuildContext context, int index) {

    return CheckboxListTile(
      title: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            if (widget.myList[index].weight != null)
              TextSpan(text: '${widget.myList[index].weight!.value} ${widget.myList[index].weight!.unit.name} / '),
            if (widget.myList[index].height != null)
              TextSpan(text: '${widget.myList[index].height!.value} ${widget.myList[index].height!.unit.name} / '),
            if (widget.myList[index].bmi != null)
              TextSpan(text: '${widget.myList[index].bmi!.value.toString()} Bmi')
          ],
        ),
      ),
      subtitle: _buildSubTitle(index),
      // tileColor: Colors.green,
      value: widget.myList[index].selected,
      onChanged: (bool? value) {
        setState(() {
          bool _itemSelection = value ?? false;
          widget.myList[index].selected = _itemSelection;
          if (_itemSelection) {
            ++selectedItems;
          } else {
            --selectedItems;
          }
        });
        assert(selectedItems >= 0 && selectedItems<=widget.myList.length);

      },
      secondary: const Icon(Icons.square_foot_outlined),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
