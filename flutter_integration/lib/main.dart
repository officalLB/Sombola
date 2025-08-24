import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'pages/home_page.dart';
import 'pages/about_page.dart';

void main() {
	runApp(const SombolaApp());
}

class SombolaApp extends StatelessWidget {
	const SombolaApp({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Sombola',
			debugShowCheckedModeBanner: false,
			theme: ThemeData(
				colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
				useMaterial3: true,
			),
			home: const HomePage(),
			routes: {
				'/about': (_) => const AboutPage(),
			},
			localizationsDelegates: const [
				GlobalMaterialLocalizations.delegate,
				GlobalWidgetsLocalizations.delegate,
				GlobalCupertinoLocalizations.delegate,
			],
			supportedLocales: const [
				Locale('en'),
				Locale('fr'),
			],
		);
	}
}