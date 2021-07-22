import 'package:first_desktop/screen/formpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 2960,
          minWidth: 400,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(color: Color(0xFFF5F5F5))),
      theme: ThemeData(
          primarySwatch: Colors.blue, accentColor: Colors.transparent),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}



///pdf opener
// String testeAcrobat = 'C:\\progra~2\\Adobe\\Acrobat Reader DC\\Reader\\AcroRd32.exe';
// try {
// print('process start');
//
// ///path of the pdf file to be opened.
// Process.run(testeAcrobat, ['C:\\test.pdf']).then((ProcessResult results) {
// print(results.stdout);
// });
// } catch (e) {
// print(e);
// }


