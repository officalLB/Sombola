from fastapi import FastAPI, UploadFile, File
from fastapi.middleware.cors import CORSMiddleware
from pydantic_settings import BaseSettings, SettingsConfigDict
from starlette.responses import JSONResponse


class Settings(BaseSettings):
	model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8")

	api_prefix: str = "/api"
	debug: bool = True
	allowed_origins: str = "*"

	@property
	def allowed_origins_list(self) -> list[str]:
		value = (self.allowed_origins or "").strip()
		if value == "*" or value == "":
			return ["*"]
		return [origin.strip() for origin in value.split(",") if origin.strip()]


settings = Settings()

app = FastAPI(debug=settings.debug, title="Sombola Backend")

app.add_middleware(
	CORSMiddleware,
	allow_origins=settings.allowed_origins_list,
	allow_credentials=True,
	allow_methods=["*"],
	allow_headers=["*"],
)


@app.get(f"{settings.api_prefix}/health")
async def health() -> JSONResponse:
	return JSONResponse({"status": "ok"})


@app.post(f"{settings.api_prefix}/detect")
async def detect(image: UploadFile = File(...)) -> JSONResponse:
	# For now, ignore the uploaded image and return a mock response
	mock_response = {
		"disease": "Leaf Blight",
		"confidence": 0.92,
		"advice": "Apply copper fungicide spray and remove infected leaves.",
	}
	return JSONResponse(mock_response)