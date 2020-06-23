import 'package:counter/i18n/app_localization.dart';
import 'package:counter/theme/light_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CounterListEmpty extends StatelessWidget {
  final Function onTap;

  const CounterListEmpty({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalization.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(64.0),
                child: Image.asset(
                  "assets/images/sun_bw.png",
                  isAntiAlias: true,
                  color: ThemeLight.scaffoldBgColor.withOpacity(0.5),
                  colorBlendMode: BlendMode.lighten,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Container(
              child: Text(
                locale.createFirstCounter,
                style: TextStyle(color: Colors.white),
              ),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
