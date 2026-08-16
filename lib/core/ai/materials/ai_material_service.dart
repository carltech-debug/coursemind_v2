import 'ai_material_ingestor.dart';
import 'models/ai_material.dart';

final class AiMaterialService {
  const AiMaterialService({
    required this.ingestor,
  });

  final AiMaterialIngestor ingestor;

  Future<String> ingest(AiMaterial material) {
    return ingestor.ingest(material);
  }
}