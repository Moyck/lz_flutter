import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lz_flutter/flutter_base.dart';
import '../widget/default_loading_dialog.dart';


abstract class BaseState<T extends StatefulWidget>  extends State<T> implements View{

  @override
  void showMsgBySnackBar(String msg,{bool needLocal = false}) {
    if(needLocal){
      msg = msg.resLocal(getContext());
    }
    Scaffold.of(getContext()).showSnackBar(SnackBar(content: new Text(msg)));
  }

  @override
  void showMsgByToast(String msg,{bool needLocal = false}) {
    if(needLocal){
      msg = msg.resLocal(getContext());
    }
    Fluttertoast.showToast(msg: msg);
  }

  @override
  void showLoadingDialog({String? msg, bool needLocal = false, bool barrierDismissible = false}) {
    if(msg!=null && needLocal){
      msg = msg.resLocal(getContext());
    }
    showDialog(
        barrierDismissible: barrierDismissible,
        context: getContext(),
        builder: (context) {
          return LoadingDialog(
            text: msg,
          );
        });

  }

  @override
  void hideLoadingDialog(){
    pop();
  }

  @override
  void pop({Object? result}) {
    Navigator.of(getContext()).pop(result);
  }

  @override
  void popTo(String routePath){
    Navigator.of(getContext()).popUntil(ModalRoute.withName(routePath));
  }

  @override
  Future<T?> routeTo<T extends Object?>(Route<T> newRoute,{bool replace = false,bool clearStack = false,RoutePredicate? predicate}) async {
    if(replace){
      return Navigator.pushReplacement(getContext(), newRoute);
    } else if(clearStack){
      return Navigator.pushAndRemoveUntil(getContext(), newRoute, predicate ?? (route) => false);
    }else{
      return Navigator.push<T>(getContext(), newRoute);
    }
  }

  @override
  BuildContext getContext() => context;

  @override
  void refresh() {
    setState(() {
      
    });
  }

}
