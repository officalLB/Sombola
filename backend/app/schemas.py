from datetime import datetime
from pydantic import BaseModel, Field


class DetectionResult(BaseModel):
    disease_name: str = Field(..., description="Mock disease name")
    confidence: float = Field(..., ge=0.0, le=1.0, description="Mock confidence between 0 and 1")
    advice: str = Field(..., description="Treatment advice (mock)")
    processed_at: datetime = Field(default_factory=datetime.utcnow)

