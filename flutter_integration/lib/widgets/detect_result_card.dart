import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DetectResultCard extends StatelessWidget {
	final DetectResult result;
	const DetectResultCard({super.key, required this.result});

	@override
	Widget build(BuildContext context) {
		final confidencePercent = (result.confidence * 100).toStringAsFixed(1);
		return Card(
			shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
			elevation: 2,
			child: Padding(
				padding: const EdgeInsets.all(16.0),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Row(
							children: [
								const Icon(Icons.eco, color: Colors.green),
								const SizedBox(width: 8),
								Text(
									result.disease,
									style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
								),
							],
						),
						const SizedBox(height: 8),
						Text('Confidence: $confidencePercent%'),
						const SizedBox(height: 8),
						Text('Advice: ${result.advice}'),
					],
				),
			),
		);
	}
}