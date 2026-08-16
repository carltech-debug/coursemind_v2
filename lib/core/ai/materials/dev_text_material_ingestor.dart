import 'ai_material_ingestor.dart';
import 'models/ai_material.dart';

final class DevTextMaterialIngestor implements AiMaterialIngestor {
  const DevTextMaterialIngestor();

  @override
  Future<String> ingest(AiMaterial material) async {
    if (material.type != AiMaterialType.text) {
      throw ArgumentError(
        'DevTextMaterialIngestor only supports text materials.',
      );
    }

    return material.source.trim();
  }
}