import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/api_service.dart';
import '../widgets/detect_result_card.dart';

class HomePage extends StatefulWidget {
	const HomePage({super.key});

	@override
	State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
	final ImagePicker _picker = ImagePicker();
	final ApiService _api = ApiService();
	XFile? _imageFile;
	DetectResult? _result;
	bool _isLoading = false;

	Future<void> _pickFromGallery() async {
		final picked = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
		if (picked != null) {
			setState(() {
				_imageFile = picked;
				_result = null;
			});
		}
	}

	Future<void> _captureFromCamera() async {
		final picked = await _picker.pickImage(source: ImageSource.camera, imageQuality: 85);
		if (picked != null) {
			setState(() {
				_imageFile = picked;
				_result = null;
			});
		}
	}

	Future<void> _analyze() async {
		if (_imageFile == null) return;
		setState(() {
			_isLoading = true;
		});
		try {
			final res = await _api.detectDisease(_imageFile!);
			setState(() {
				_result = res;
			});
		} catch (e) {
			if (!mounted) return;
			ScaffoldMessenger.of(context).showSnackBar(
				SnackBar(content: Text('Error: $e')),
			);
		} finally {
			if (mounted) {
				setState(() {
					_isLoading = false;
				});
			}
		}
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Sombola'),
				actions: [
					IconButton(
						icon: const Icon(Icons.info_outline),
						onPressed: () => Navigator.pushNamed(context, '/about'),
					)
				],
			),
			body: Padding(
				padding: const EdgeInsets.all(16.0),
				child: Column(
					children: [
						Expanded(
							child: Center(
								child: _imageFile == null
									? const Text('Capture or select a leaf photo to start')
									: Image.file(File(_imageFile!.path)),
							),
						),
						if (_result != null) DetectResultCard(result: _result!),
						const SizedBox(height: 12),
						Row(
							children: [
								Expanded(
									child: ElevatedButton.icon(
										icon: const Icon(Icons.photo_camera),
										label: const Text('Camera'),
										onPressed: _captureFromCamera,
									),
								),
								const SizedBox(width: 12),
								Expanded(
									child: OutlinedButton.icon(
										icon: const Icon(Icons.photo_library),
										label: const Text('Gallery'),
										onPressed: _pickFromGallery,
									),
								),
							],
						),
						const SizedBox(height: 12),
						SizedBox(
							width: double.infinity,
							child: FilledButton(
								onPressed: _imageFile == null || _isLoading ? null : _analyze,
								child: _isLoading
									? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2))
									: const Text('Analyze'),
							),
						),
					],
				),
			),
		);
	}
}