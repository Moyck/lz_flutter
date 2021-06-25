import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:lz_flutter/src/config/debugger_config.dart';
import 'package:lz_flutter/src/debugger/debugger_exceptions_detail_page/debugger_exceptions_detail_page.dart';
import 'package:lz_flutter/src/debugger/domain/lz_flutter_error_detail.dart';

class DebuggerExceptionsPage extends StatefulWidget {
  @override
  _DebuggerExceptionsPageState createState() => _DebuggerExceptionsPageState();
}

class _DebuggerExceptionsPageState extends State<DebuggerExceptionsPage> {
  List<LZFlutterErrorDetail> errors = [];

  @override
  void initState() {
    super.initState();
    errors = List.from(flutterErrorDetails);
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
          child: SingleChildScrollView(child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 5, 20),
                      child: Text('Exception',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30))),
                  Hero(
                      tag: 'bug_icon',
                      child:   Icon(
                        Icons.bug_report,
                        color: Colors.redAccent,
                        size: 30,
                      ),),
                ],
              ),
              for (LZFlutterErrorDetail errorDetail in errors)
                InkWell(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return DebuggerExceptionsDetailPage(errorDetail,'detail${errors.indexOf(errorDetail)}');
                  }));
                },child: 
                    Hero(tag: 'detail${errors.indexOf(errorDetail)}', child: 
                Card(
                    margin: const EdgeInsets.fromLTRB(3, 10, 3, 5),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              errorDetail.details.exception.toString(),
                              textAlign: TextAlign.start,
                              style:
                              const TextStyle(fontWeight: FontWeight.w900,fontSize: 16),
                              maxLines: 3
                            ),
                            Container(height: 10),
                            Text(
                              errorDetail.details.stack.toString(),
                              maxLines: 10,
                            ),
                          ],
                        )))))
            ],
          ))));
}
