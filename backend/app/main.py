from fastapi import FastAPI, UploadFile, File
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse

from .config import AppSettings, HealthResponse
from .schemas import DetectionResult


settings = AppSettings()
app = FastAPI(title="Sombola – AI Crop Disease Detection API", debug=settings.debug)

# Configure CORS
allow_origins = [o.strip() for o in settings.cors_allow_origins.split(",") if o.strip()] if settings.cors_allow_origins != "*" else ["*"]
allow_methods = [m.strip() for m in settings.cors_allow_methods.split(",") if m.strip()] if settings.cors_allow_methods != "*" else ["*"]
allow_headers = [h.strip() for h in settings.cors_allow_headers.split(",") if h.strip()] if settings.cors_allow_headers != "*" else ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=allow_origins,
    allow_credentials=settings.cors_allow_credentials,
    allow_methods=allow_methods,
    allow_headers=allow_headers,
)


@app.get(f"{settings.api_base_path}/health", response_model=HealthResponse)
def health_check() -> HealthResponse:
    return HealthResponse(status="ok")


@app.post(f"{settings.api_base_path}/detect", response_model=DetectionResult)
async def detect_disease(image: UploadFile = File(...)) -> DetectionResult:
    # Placeholder: In the future, read file bytes and run model inference
    _ = await image.read()
    return DetectionResult(
        disease_name="Leaf Blight (mock)",
        confidence=0.92,
        advice="Remove infected leaves, apply copper-based fungicide, improve air circulation.",
    )


@app.get("/")
def root() -> JSONResponse:
    return JSONResponse({"message": "Sombola API. See /docs"})

