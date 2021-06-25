import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter/src/debugger/domain/request_result.dart';

class DebuggerNetworkDetailPage extends StatefulWidget {
  final RequestResult result;
  final index;

  const DebuggerNetworkDetailPage(this.result, this.index);

  @override
  _DebuggerNetworkDetailPageState createState() =>
      _DebuggerNetworkDetailPageState();
}

class _DebuggerNetworkDetailPageState
    extends BaseState<DebuggerNetworkDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late RequestData? _requestData;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _requestData = widget.result.request!;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 5, 20),
                  child: Text('Overview',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30))),
              Hero(
                  tag: 'result${widget.index}',
                  child: Card(
                      margin: const EdgeInsets.fromLTRB(3, 10, 3, 5),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      color: Colors.white,
                      elevation: 5,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                          child: Row(
                            children: [
                              Text(
                                widget.result.stateCode.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: getStateCodeColor(
                                        widget.result.stateCode)),
                              ),
                              Container(width: 10),
                              Text(widget.result.method,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              Container(width: 15),
                              Expanded(
                                  child: Text(widget.result.methodName,
                                      style: TextStyle(
                                          color: Colors.black.withAlpha(210),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14))),
                              Container(width: 10),
                              Text(
                                  formatDate(widget.result.time,
                                      [HH, ':', nn, ':', ss]),
                                  style: TextStyle(
                                      color: Colors.black.withAlpha(120),
                                      fontWeight: FontWeight.w600)),
                            ],
                          )))),
              Expanded(
                  child: Card(
                      margin: const EdgeInsets.fromLTRB(3, 10, 3, 5),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      color: Colors.white,
                      elevation: 5,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: InkWell(
                                          onTap: () {
                                            _requestData =
                                                widget.result.request;
                                            refresh();
                                          },
                                          child:  Center(
                                              child: Padding(
                                                  padding: const EdgeInsets.all(10),
                                                  child: Text(
                                                    'Request',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,color: _requestData == widget.result.request ? Colors.black : Colors.grey),
                                                  ))))),
                                  Container(
                                      height: 20, width: 1, color: Colors.grey),
                                  Expanded(
                                      child: InkWell(
                                          onTap: () {
                                            _requestData =
                                                widget.result.response;
                                            refresh();
                                          },
                                          child:  Center(
                                              child: Padding(
                                                  padding: const EdgeInsets.all(10),
                                                  child: Text('Response',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: _requestData == widget.result.response ? Colors.black : Colors.grey)))))),
                                ],
                              ),
                              Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey,
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0)),
                              TabBar(
                                  controller: _tabController,
                                  labelColor: Colors.black,
                                  indicatorWeight: 5,
                                  tabs: const [
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 20, 0, 10),
                                        child: Text('Headers')),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 20, 0, 10),
                                        child: Text('Body')),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 20, 0, 10),
                                        child: Text('Other'))
                                  ]),
                              Expanded(
                                  child: TabBarView(
                                controller: _tabController,
                                children: [
                                  SingleChildScrollView(child:  getHeaderWidget()),
                                  SingleChildScrollView(child:  getBodyWidget()),
                                  SingleChildScrollView(child:  Container()),
                                ],
                              ))
                            ],
                          )))),
            ],
          )));

  Widget getHeaderWidget() {
    List<Widget> children = [];
    _requestData!.header.forEach((key, value) {
      children.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: 10),
          Text(
            key,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value.toString()),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey,
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          )
        ],
      ));
    });
    return Column(mainAxisSize: MainAxisSize.min, children: children);
  }

  Widget getBodyWidget() => Padding(
      padding: const EdgeInsets.all(10), child: Text(_requestData?.body ?? ''));

  Color getStateCodeColor(int stateCode) {
    if (stateCode < 300) {
      return Colors.green;
    } else if (stateCode < 400) {
      return Colors.orangeAccent;
    } else if (stateCode < 500) {
      return Colors.red;
    } else {
      return Colors.redAccent;
    }
  }
}
