import 'models/ai_material.dart';

abstract interface class AiMaterialIngestor {
  Future<String> ingest(AiMaterial material);
}