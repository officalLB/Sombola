import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
	const AboutPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('About Sombola')),
			body: Padding(
				padding: const EdgeInsets.all(16.0),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: const [
						Text(
							'Sombola',
							style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
						),
						SizedBox(height: 12),
						Text(
							'Sombola helps farmers detect crop diseases using a simple photo of a leaf. It provides clear results and practical advice you can use in the field.',
							style: TextStyle(fontSize: 16),
						),
						SizedBox(height: 12),
						Text('Multilingual-ready and farmer-friendly.'),
					],
				),
			),
		);
	}
}