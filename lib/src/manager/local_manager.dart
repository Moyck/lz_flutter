import 'package:flutter/material.dart';

import '../config/config.dart';


class LocalManager {

  static LocalManager? _instance;

  static LocalManager getInstance() {
    if (_instance == null) _instance = LocalManager();
    return _instance!;
  }

  String? local(BuildContext context,String key) {
    return getLocalRes(context,key);
  }

  List<String>? stringList( BuildContext context,String key) {
    return getLocalRes(context,key);
  }

  dynamic getLocalRes(BuildContext context,String key){
    var localRes = Config.getInstance().resourceConfig.getLocalRes();
    if(localRes[getLanguageCode(context,true)] != null && localRes[getLanguageCode(context,true)][key] != null)
      return localRes[getLanguageCode(context,true)][key];
    if(localRes[getLanguageCode(context,false)] != null && localRes[getLanguageCode(context,false)][key] != null)
      return localRes[getLanguageCode(context,false)][key];
    if(localRes[Config.getInstance().resourceConfig.getDefaultLanguageCode()] != null && localRes[Config.getInstance().resourceConfig.getDefaultLanguageCode()][key] != null)
      return localRes[Config.getInstance().resourceConfig.getDefaultLanguageCode()][key];
    assert(true,'未定义的资源');
    return null;
  }

  String getLanguageCode(BuildContext context,bool withArea){
    if(Config.getInstance().resourceConfig.getCurrentLanguageCode()!=null)
      return Config.getInstance().resourceConfig.getCurrentLanguageCode();
    var local = Localizations.localeOf(context);
    if(withArea)
      return local.languageCode + "-" + (local.countryCode ?? '');
    else
      return local.languageCode;
  }

}
