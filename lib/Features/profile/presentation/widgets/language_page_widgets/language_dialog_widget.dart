import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/theme/app_color/app_color_light.dart';
import 'package:aid_humanity/core/utils/theme/cubit/theme_cubit.dart';
import 'package:aid_humanity/core/widgets/custom_divider_widget.dart';
import 'package:aid_humanity/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangageDialogWidget extends StatefulWidget {
  const LangageDialogWidget({super.key});

  @override
  State<LangageDialogWidget> createState() => _LangageDialogWidgetState();
}

class _LangageDialogWidgetState extends State<LangageDialogWidget> {
  int selectedValue = 1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.getDefaultSize() * 13,
      width: context.getDefaultSize() * 38,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomDividerWidget(thickness: 1.0, whiteSpaceBegin: 15),
          ListTile(
            title: const Text(
              "English",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Radio<int>(
              value: 1,
              groupValue: getIt<SharedPreferences>().getInt('lang')??selectedValue,
              onChanged: (value) {
                setState(() {
                  BlocProvider.of<ThemeCubit>(context).changeLocale(const Locale('en'));
                });
              },
              fillColor: MaterialStateProperty.all(AppColorsLight.primaryColor),
              toggleable: true,
            ),
          ),
          const CustomDividerWidget(thickness: 1.0, whiteSpaceBegin: 15),
          ListTile(
            title: const Text("العربية", style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Radio<int>(
              value: 2,
              groupValue: getIt<SharedPreferences>().getInt('lang')??selectedValue,
              onChanged: (value) {
                setState(() {
                  
                    getIt<SharedPreferences>().setInt('lang', 2);
                  BlocProvider.of<ThemeCubit>(context).changeLocale(const Locale('ar'));
                });
              },
              fillColor: MaterialStateProperty.all(AppColorsLight.primaryColor),
              toggleable: true,
            ),
          ),
        ],
      ),
    );
  }
}
