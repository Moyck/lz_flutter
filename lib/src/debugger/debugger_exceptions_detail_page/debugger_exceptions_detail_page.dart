import 'package:flutter/material.dart';
import 'package:lz_flutter/src/debugger/domain/lz_flutter_error_detail.dart';

class DebuggerExceptionsDetailPage extends StatefulWidget {
  LZFlutterErrorDetail _lzFlutterErrorDetail;
  String heroTag;

  DebuggerExceptionsDetailPage(this._lzFlutterErrorDetail, this.heroTag);

  @override
  _DebuggerExceptionsDetailPageState createState() =>
      _DebuggerExceptionsDetailPageState();
}

class _DebuggerExceptionsDetailPageState
    extends State<DebuggerExceptionsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Hero(
                tag: widget.heroTag,
                child: Card(
                    margin: const EdgeInsets.fromLTRB(3, 0, 3, 5),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: SingleChildScrollView(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget._lzFlutterErrorDetail.details.exception
                                  .toString(),
                              textAlign: TextAlign.start,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w900,fontSize: 16),
                            ),
                            Container(height: 10),
                            Text(
                              widget._lzFlutterErrorDetail.details.stack
                                  .toString(),
                            ),
                          ],
                        )))))));
  }
}
