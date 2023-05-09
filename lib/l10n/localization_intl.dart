import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart'; // "messages_all.dart" 文件是通过 intl_generator 工具从arb文件生成的代码，所以在第一次运行生成命令之前，此文件不存在。

class DemoLocalizations {
  static Future<DemoLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    // initializeMessages() 方法和 "messages_all.dart" 文件一样，是同时生成的。
    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return DemoLocalizations();
    });
  }

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations)!;
  }

  String get title {
    return Intl.message(
      'Flutter App',
      name: 'title',
      desc: 'Title for the Demo application',
    );
  }

  String get switchLanguage {
    return Intl.message(
      'Switch Language',
      name: 'switchLanguage',
      desc: 'Switch Language 123123',
    );
  }

  remainingEmailsMessage(int howMany) => Intl.plural(howMany,
      zero: 'There are no emails left',
      one: 'There is $howMany email left',
      other: 'There are $howMany emails left',
      name: "remainingEmailsMessage",
      args: [howMany],
      desc: "How many emails remain after archiving.",
      examples: const {'howMany': 42, 'userName': 'Fred'});
}

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
    return DemoLocalizations.load(locale);
  }

  // 当Localizations Widget重新build时，是否调用load重新加载Locale资源.
  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}
