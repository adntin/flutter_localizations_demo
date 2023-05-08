import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './demo_localizations.dart';

//Locale代理类
class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  //是否支持某个Local
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  // Flutter会调用此类加载相应的Locale资源类
  @override
  Future<DemoLocalizations> load(Locale locale) {
    print("$locale");
    return SynchronousFuture<DemoLocalizations>(
        DemoLocalizations(locale.languageCode == "zh"));
  }

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}
