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
                  "assets/images/flor.png",
                  isAntiAlias: true,
                  color: ThemeLight.scaffoldBgColor.withOpacity(0.75),
                  colorBlendMode: BlendMode.lighten,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xff555555),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                splashColor: Color(0xff999999),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Text(
                    locale.createFirstCounter,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
