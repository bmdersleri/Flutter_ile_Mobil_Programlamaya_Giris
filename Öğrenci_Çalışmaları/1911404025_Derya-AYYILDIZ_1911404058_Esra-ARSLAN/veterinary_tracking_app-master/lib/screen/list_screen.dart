import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class ListScreen extends StatefulWidget {
  List items;
  ListScreen({required this.items});
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  HDTRefreshController _hdtRefreshController = HDTRefreshController();

  static const int sortAnimalId = 0;
  static const int sortConductivity = 1;
  static const int sortMilkQuantity = 2;
  static const int sortMovement = 3;
  bool isAscending = true;
  int sortType = sortAnimalId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mastitis Tahlilleri"),
      ),
      body: _getBodyWidget(),
    );
  }

  Widget _getBodyWidget() {
    return Container(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 100,
        rightHandSideColumnWidth: 300,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: widget.items.length,
        rowSeparatorWidget: Divider(
          color: Colors.black54,
          height: 1.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
        verticalScrollbarStyle: const ScrollbarStyle(
          thumbColor: Colors.yellow,
          isAlwaysShown: true,
          thickness: 4.0,
          radius: Radius.circular(5.0),
        ),
        horizontalScrollbarStyle: const ScrollbarStyle(
          thumbColor: Colors.red,
          isAlwaysShown: true,
          thickness: 4.0,
          radius: Radius.circular(5.0),
        ),
        enablePullToRefresh: true,
        refreshIndicator: const WaterDropHeader(),
        refreshIndicatorHeight: 60,
        onRefresh: () async {
          //Do sth
          await Future.delayed(const Duration(milliseconds: 500));
          _hdtRefreshController.refreshCompleted();
        },
        enablePullToLoadNewData: true,
        loadIndicator: const ClassicFooter(),
        onLoad: () async {
          //Do sth
          await Future.delayed(const Duration(milliseconds: 500));
          _hdtRefreshController.loadComplete();
        },
        htdRefreshController: _hdtRefreshController,
      ),
      height: MediaQuery.of(context).size.height,
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            'Hayvan ID' +
                (sortType == sortAnimalId ? (isAscending ? '↓' : '↑') : ''),
            100),
        onPressed: () {
          animalSort(isAscending, widget.items);
          sortType = sortAnimalId;
          isAscending = !isAscending;
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        
        child: _getTitleItemWidget(
            'Mastitis Sonucu' +
                (sortType == sortMovement ? (isAscending ? '↓' : '↑') : ''),
            100),
        onPressed: () { 
          sortType = sortMovement;
          mastitisSort(isAscending, widget.items);
          isAscending = !isAscending;
          setState(() {});
        },
      ),
          TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        
        child: _getTitleItemWidget(
            'Tarih ' +
                (sortType == sortMovement ? (isAscending ? '↓' : '↑') : ''),
            100),
        onPressed: () { 
          sortType = sortMovement;
          mastitisSort(isAscending, widget.items);
          isAscending = !isAscending;
          setState(() {});
        },
      ),
     
      
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      width: 100,
      height: 56,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      child: Text(
        widget.items[index].animalId.toString(),
        style: Theme.of(context).textTheme.button,
      ),
      width: 100,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        
      
        Container(
          child: Text(widget.items[index].mastitisValue.toString()),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),Container(
          child: Text(widget.items[index].dateTime.toString()),
          width: 150,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }

  void animalSort(isAscending, list) {
    list.sort((a, b) {
      int aValue = int.parse(a.animalId);
      int bValue = int.parse(b.animalId);
      return (aValue - bValue) * (isAscending ? 1 : -1);
    });
  }

  void mastitisSort(isAscending, list) {
    list.sort((a, b) {
      int aValue = (a.mastitisValue * 10).toInt();
      int bValue = (b.mastitisValue * 10).toInt();
      return (aValue - bValue) * (isAscending ? 1 : -1);
    });
  }

  
}
