abstract class IResourceConfig {

  /**
   * 国际化配置
   */
  IResourceConfig setLocalRes(Map localRes);

  Map getLocalRes();

  /**
   * 设置当前语言
   */
  IResourceConfig setCurrentLanguageCode(String value);

  String getCurrentLanguageCode();

  /**
   * 设置默认语言
   */
  IResourceConfig setDefaultLanguageCode(String value);

  String getDefaultLanguageCode();
  
  IResourceConfig setDesignSize(double width,double height,{double density = 3.0});
}
