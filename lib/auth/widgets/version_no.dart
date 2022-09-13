import 'package:customer_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class CurrentVersion extends StatelessWidget {
  const CurrentVersion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, AsyncSnapshot<PackageInfo> snapshot) {
          String appName = '';
          // String packageName = '';
          String version = '';
          // String buildNumber = '';
          if (snapshot.hasData) {
            // packageName = packageInfo.packageName;
            appName = snapshot.data!.appName;
            version = snapshot.data!.version;
            // buildNumber = snapshot.data!.buildNumber;
          }
          return Text(
            '$appName v$version',
            style: ThemeConf().normalTextStyle(
              context,
              fontSizeFactor: 0.8,
            ),
          );
        });
  }
}
