# Sombola
Sombola is an AI-driven mobile application designed to help farmers detect and classify crop diseases instantly using just a photo of a plant leaf. By leveraging computer vision and deep learning, Sombola provides smallholder farmers with accurate diagnoses and actionable treatment advice, even in areas with poor internet connectivity

## Project Structure
- `backend/`: FastAPI service exposing `/api/health` and `/api/detect`
- Flutter app: existing source in this repository (connects to backend via config)

## Backend (FastAPI)

### Features
- CORS enabled for Flutter/web usage
- `.env` driven configuration
- Dockerized

### Endpoints
- `GET /api/health` → `{ "status": "ok" }`
- `POST /api/detect` → accepts `multipart/form-data` with `image` file; returns mock JSON:
  ```json
  {
    "disease": "Leaf Blight",
    "confidence": 0.92,
    "advice": "Apply copper fungicide spray and remove infected leaves."
  }
  ```

### Local Development

Prerequisites: Python 3.11+

```bash
cd backend
python -m venv .venv
source .venv/bin/activate  # Windows: .venv\\Scripts\\activate
pip install -r requirements.txt
cp .env.example .env
./uvicorn.sh  # Windows: uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
```

Open: `http://localhost:8000/docs` for Swagger UI.

### Docker
```bash
cd backend
cp .env.example .env
docker build -t sombola-backend .
docker run --rm -it -p 8000:8000 --env-file .env sombola-backend
```

## Frontend (Flutter)

Configure API base URL in `lib/config/api_config.dart` (created/updated in this repo):
```dart
class ApiConfig {
	static const String baseUrl = String.fromEnvironment(
		'SOMBOLA_API_BASE_URL',
		defaultValue: 'http://localhost:8000',
	);
}
```

App features:
- Capture/upload image
- Calls `/api/detect`
- Displays disease, confidence %, and advice
- About page: app description

### Run
```bash
flutter pub get
flutter run --dart-define=SOMBOLA_API_BASE_URL=http://localhost:8000
```

## GitHub

Initialize and push:
```bash
git init
git add .
git commit -m "feat: add FastAPI backend and integrate Flutter frontend"
git branch -M main
git remote add origin <YOUR_GITHUB_REPO_URL>
git push -u origin main
```

## Notes
- The `/api/detect` endpoint returns a mock response; integrate your ML model later.
- Keep backend and frontend under this repo for local development parity.
