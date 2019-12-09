import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/mixins/mixins.dart';
import 'package:flutter_app/src/constants/constants.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/widgets/widgets.dart';

class MainDrawer extends StatefulWidget with ThemeMixin {
  const MainDrawer();

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<NavigationBloc>(context).add(SetMainDrawerItemOptions(
      options: getMainDrawerItemOptions(context),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                S.of(context).mainMenu,
                style: widget.getPrimaryTextTheme(context).display1,
              ),
            ),
            decoration: BoxDecoration(
              color: widget.getTheme(context).primaryColor,
            ),
          ),
          Row(
            // TODO refactor
            children: <Widget>[
              BlocBuilder<PreferencesBloc, PreferencesState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: DropdownButton<ThemeMode>(
                      value: state.themeMode,
                      style: widget.getTextTheme(context).body1,
                      onChanged: (ThemeMode themeMode) {
                        BlocProvider.of<PreferencesBloc>(context)
                            .add(ChooseThemeMode(themeMode));
                      },
                      items: ThemeMode.values.map<DropdownMenuItem<ThemeMode>>(
                          (ThemeMode themeMode) {
                        return DropdownMenuItem<ThemeMode>(
                          value: themeMode,
                          child: Text(
                              '${S.of(context).theme} - ${describeEnum(themeMode)}'),
                        );
                      }).toList(),
                    ),
                  );
                },
              )
            ],
          ),
          Row(
            children: <Widget>[
              BlocBuilder<PreferencesBloc, PreferencesState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: DropdownButton<Locale>(
                      value: state.locale,
                      style: widget.getTextTheme(context).body1,
                      onChanged: (Locale locale) {
                        if (locale.languageCode ==
                            describeEnum(SupportedLanguages.en)) {
                          BlocProvider.of<PreferencesBloc>(context)
                              .add(const ChooseLanguage(SupportedLanguages.en));
                        }

                        if (locale.languageCode ==
                            describeEnum(SupportedLanguages.ru)) {
                          BlocProvider.of<PreferencesBloc>(context)
                              .add(const ChooseLanguage(SupportedLanguages.ru));
                        }
                      },
                      items: SupportedLanguages.values
                          .map<DropdownMenuItem<Locale>>(
                              (SupportedLanguages supportedLanguage) {
                        return DropdownMenuItem<Locale>(
                          value:
                              mapLanguagesEnumToLocale[supportedLanguage.index],
                          child: Text(
                              '${S.of(context).language} - ${describeEnum(supportedLanguage)}'),
                        );
                      }).toList(),
                    ),
                  );
                },
              )
            ],
          ),
          Expanded(
            flex: 1,
            child: BlocBuilder<NavigationBloc, NavigationState>(
              builder: (context, state) {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: state.mainDrawerItemOptions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return DrawerItem(
                      selected: state.activeDrawerIndex == index,
                      title: state.mainDrawerItemOptions[index].title,
                      routeName: state.mainDrawerItemOptions[index].routeName,
                      icon: state.mainDrawerItemOptions[index].icon,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
