import 'package:demo/bloc/all.dart';
import 'package:demo/models/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:styled_widget/styled_widget.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(builder: (context, state) {
      page({required Widget child}) => Scaffold(
            appBar: AppBar(
              title: Text(
                AppLocalizations.of(context)!.language_title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
            ),
            body: child,
          );

      final languages = <Language>[
        Language(
          name: 'English',
          code: 'en',
        ),
        Language(
          name: '中文',
          code: 'zh',
        ),
      ];

      final Widget languageRadioList = ListView.builder(
          itemBuilder: (context, index) {
            final language = languages[index];
            return RadioListTile<Locale>(
              title: Text(language.name),
              value: Locale(language.code),
              groupValue: state,
              onChanged: (locale) =>
                  context.read<LocaleCubit>().changeLocale(locale!),
            );
          },
          itemCount: languages.length);

      return languageRadioList.parent(page);
    });
  }
}
