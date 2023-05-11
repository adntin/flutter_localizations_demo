import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // // localizationDelegates 数组是用于生成本地化值集合的工厂。
      // localizationsDelegates: const [
      //   // 1. 本地化的代理类
      //   // 1.1 GlobalMaterialLocalizations.delegate 为 Material 组件库提供本地化的字符串和一些其他的值。
      //   GlobalMaterialLocalizations.delegate,
      //   // 1.2 GlobalWidgetsLocalizations.delegate 为 widgets 库定义了默认的文本排列方向，由左到右或者由右到左。
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      //   // 2. 注册我们的 Delegate
      //   DemoLocalizationsDelegate(),
      // ],
      // supportedLocales: const [
      //   Locale('en', 'US'), // 美国英语
      //   Locale('zh', 'CN'), // 中文简体
      // ],
      // locale: const Locale('zh', 'HK'), // 赋值表示: 程序语言 > 系统语言
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // title: 'Flutter App',
      onGenerateTitle: (context) {
        // 此时context在Localizations的子树中
        return AppLocalizations.of(context).title;
      },
      localeListResolutionCallback: (locales, supportedLocales) {
        print("deviceLocales: $locales, supportedLocales: $supportedLocales");
        if (locales == null) {
          return supportedLocales.first; // null ==> en
        }
        for (Locale l in locales) {
          Iterable<Locale> supportedLocales1 =
              supportedLocales.where((s) => s.languageCode == l.languageCode);
          if (supportedLocales1.isEmpty) {
            return supportedLocales.first; // ja ==> en
          }
          Iterable<Locale> supportedLocales2 =
              supportedLocales1.where((s) => s.countryCode == l.countryCode);
          if (supportedLocales2.isNotEmpty) {
            return supportedLocales2.first; // zh_CN ==> zh_CN
          } else {
            return Locale(l.languageCode); // zh_TW ==> zh
          }
        }
        return supportedLocales.first; // 兜底 ==> en (这行代码不应该执行)
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(Localizations.localeOf(context).toString()),
            Text(AppLocalizations.of(context).helloWorld),
            Text(AppLocalizations.of(context).helloSomebody('Devin')),
            Text(AppLocalizations.of(context)
                .helloWorldOn(DateTime.utc(1996, 7, 10))),
            Text(AppLocalizations.of(context).totalPrice(12345.236)),
            Text(
                AppLocalizations.of(context).remainingEmailsMessage(42, 'Dan')),
            // Localizations.override(
            //   context: context,
            //   locale: const Locale('es'), // 西班牙语
            //   // Using a Builder to get the correct BuildContext.
            //   // Alternatively, you can create a new widget and Localizations.override
            //   // will pass the updated BuildContext to the new widget.
            //   child: Builder(
            //     builder: (context) {
            //       return CalendarDatePicker(
            //         initialDate: DateTime.now(),
            //         firstDate: DateTime(1900),
            //         lastDate: DateTime(2100),
            //         onDateChanged: (value) {},
            //       );
            //     },
            //   ),
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: AppLocalizations.supportedLocales
                  .toList()
                  .map((Locale locale) {
                if (locale.countryCode == null) {
                  return Container();
                }
                return ElevatedButton(
                  onPressed: () {
                    print(locale.toString());
                  },
                  child: Text(locale.toString()),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
