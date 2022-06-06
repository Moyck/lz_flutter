import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widget/default_loading_dialog.dart';

abstract class View {

  BuildContext getContext();

  void showMsgBySnackBar(String msg,{bool needLocal = false });

  void showMsgByToast(String msg,{bool needLocal = false});

  void showLoadingDialog({String msg,bool needLocal = false ,bool barrierDismissible = false});

  void hideLoadingDialog({bool rootNavigator = false});

  void pop({Object? result,bool rootNavigator = false});

  void popTo(String routePath);

  void refresh();

  Future<T?> routeTo<T extends Object?>(Route<T> newRoute,{bool replace = false,bool clearStack = false,RoutePredicate? predicate,bool rootNavigator = false});

}