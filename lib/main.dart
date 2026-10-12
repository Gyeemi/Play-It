import 'package:flutter/material.dart';

/// PLAT IT - SOCIAL MUSIC
/// (c) Baraily Innovation
///
/// Phase 0 foundation build: app shell, platform-adaptive navigation
/// (bottom bar on phones, NavigationRail on Windows/desktop),
/// light/dark themes, branded identity.
/// Local playback, social and broadcast modules land in Phases 1-4
/// per the architecture document.
void main() => runApp(const PlatItApp());

class PlatItApp extends StatefulWidget {
  const PlatItApp({super.key});
  @override
  State<PlatItApp> createState() => _PlatItAppState();
}

class _PlatItAppState extends State<PlatItApp> {
  ThemeMode _themeMode = ThemeMode.system;
  void _toggleTheme() => setState(() {
        _themeMode =
            _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plat it',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      home: AppShell(onToggleTheme: _toggleTheme, isDark: _themeMode == ThemeMode.dark),
    );
  }
}

ThemeData _buildTheme(Brightness b) {
  final scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF1E6FEB), // Plat it blue
    brightness: b,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    appBarTheme: AppBarTheme(centerTitle: false, backgroundColor: scheme.surface),
  );
}

class AppSection {
  final String title;
  final IconData icon;
  const AppSection(this.title, this.icon);
}

const sections = [
  AppSection('Home', Icons.home_outlined),
  AppSection('My Music', Icons.library_music_outlined),
  AppSection('YouTube', Icons.play_circle_outline),
  AppSection('Live', Icons.podcasts_outlined),
  AppSection('Social', Icons.people_outline),
  AppSection('Downloads', Icons.download_outlined),
  AppSection('Settings', Icons.settings_outlined),
];

class AppShell extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDark;
  const AppShell({super.key, required this.onToggleTheme, required this.isDark});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 900;
    final body = _SectionBody(section: sections[_index]);

    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Image.asset('assets/logo.png', width: 28, height: 28,
              errorBuilder: (_, __, ___) => const Icon(Icons.play_circle_fill)),
          const SizedBox(width: 8),
          const Text('Plat it'),
        ]),
        actions: [
          IconButton(
            tooltip: widget.isDark ? 'Light mode' : 'Dark mode',
            icon: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: wide
          ? Row(children: [
              NavigationRail(
                selectedIndex: _index,
                onDestinationSelected: (i) => setState(() => _index = i),
                labelType: NavigationRailLabelType.all,
                destinations: sections
                    .map((s) => NavigationRailDestination(
                        icon: Icon(s.icon), label: Text(s.title)))
                    .toList(),
              ),
              const VerticalDivider(width: 1),
              Expanded(child: body),
            ])
          : body,
      bottomNavigationBar: wide
          ? null
          : NavigationBar(
              selectedIndex: _index < 5 ? _index : 0,
              onDestinationSelected: (i) => setState(() => _index = i),
              destinations: sections
                  .take(5)
                  .map((s) =>
                      NavigationDestination(icon: Icon(s.icon), label: s.title))
                  .toList(),
            ),
    );
  }
}

class _SectionBody extends StatelessWidget {
  final AppSection section;
  const _SectionBody({required this.section});

  @override
  Widget build(BuildContext context) {
    // Honest empty states. Feature modules are implemented in
    // Phases 1-6 of the roadmap - no fake buttons or mock controls.
    return Column(children: [
      Expanded(
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(section.icon, size: 56,
                color: Theme.of(context).colorScheme.outline),
            const SizedBox(height: 12),
            Text(section.title,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('Coming online in a later milestone',
                style: Theme.of(context).textTheme.bodySmall),
          ]),
        ),
      ),
      // Persistent mini-player placeholder bar: shows a truthful idle state.
      Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          border: Border(top: BorderSide(
              color: Theme.of(context).dividerColor, width: 0.5)),
        ),
        child: Row(children: [
          const Icon(Icons.music_note),
          const SizedBox(width: 12),
          Expanded(child: Text('Nothing playing',
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis)),
          const Icon(Icons.play_arrow),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.all(4),
        child: Text('© Baraily Innovation',
            style: Theme.of(context).textTheme.labelSmall),
      ),
    ]);
  }
}
