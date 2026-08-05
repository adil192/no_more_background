import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logging/logging.dart';
import 'package:no_more_background/data/fonts.dart';
import 'package:no_more_background/data/log_history.dart';
import 'package:no_more_background/i18n/strings.g.dart';
import 'package:yaru/yaru.dart';

class LogsPage extends HookWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final records = useValueListenable(logHistory);

    final theme = Theme.of(context);
    final monoStyle = TextStyle(
      fontFamily: kMonoFont.primary,
      fontFamilyFallback: kMonoFont.fallbacks,
    );
    return Scaffold(
      appBar: AppBar(title: Text(t.logs.title)),
      body: ListView.builder(
        itemCount: records.length,
        itemBuilder: (context, index) {
          final record = records[records.length - index - 1];
          return Padding(
            padding: const .only(bottom: 16),
            child: ColoredBox(
              color: record.level.containerColor,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: .start,
                    children: [
                      Icon(record.level.icon, size: 32),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(record.loggerName, style: monoStyle),
                            Text(record.message),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (record.stackTrace != null)
                    Text(
                      record.stackTrace!.toString(),
                      style: monoStyle.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

extension on Level {
  Color get containerColor {
    return switch (this) {
      Level.SHOUT => const Color(0x10FF0000),
      Level.SEVERE => const Color(0x0AFF0000),
      _ => Colors.transparent,
    };
  }

  IconData get icon {
    return switch (this) {
      Level.SHOUT || Level.SEVERE => YaruIcons.error,
      Level.WARNING => YaruIcons.warning,
      _ => YaruIcons.information,
    };
  }
}
