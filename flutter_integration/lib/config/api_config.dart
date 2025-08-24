class ApiConfig {
	static const String baseUrl = String.fromEnvironment(
		'SOMBOLA_API_BASE_URL',
		defaultValue: 'http://localhost:8000',
	);
}