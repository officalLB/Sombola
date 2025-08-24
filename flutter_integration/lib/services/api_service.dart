import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../config/api_config.dart';

class DetectResult {
	final String disease;
	final double confidence;
	final String advice;

	DetectResult({required this.disease, required this.confidence, required this.advice});

	factory DetectResult.fromJson(Map<String, dynamic> json) {
		return DetectResult(
			disease: json['disease'] as String,
			confidence: (json['confidence'] as num).toDouble(),
			advice: json['advice'] as String,
		);
	}
}

class ApiService {
	final String _baseUrl = ApiConfig.baseUrl;

	Future<DetectResult> detectDisease(XFile imageFile) async {
		final uri = Uri.parse('$_baseUrl/api/detect');
		final request = http.MultipartRequest('POST', uri);
		request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
		final streamed = await request.send();
		final response = await http.Response.fromStream(streamed);
		if (response.statusCode != 200) {
			throw Exception('Failed to detect disease: ${response.statusCode}');
		}
		final data = json.decode(response.body) as Map<String, dynamic>;
		return DetectResult.fromJson(data);
	}
}