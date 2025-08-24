import 'package:flutter/material.dart';
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
			supportedLocales: const [
				Locale('en'),
				Locale('fr'),
			],
		);
	}
}