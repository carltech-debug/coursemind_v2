import 'material_r2_datasource.dart';

final class CloudflareR2DataSource
    implements MaterialR2DataSource {
  const CloudflareR2DataSource();

  @override
  Future<String> upload({
    required String storagePath,
    required String fileName,
    required String contentType,
    required List<int> bytes,
  }) {
    throw UnimplementedError(
      'Cloudflare R2 upload is not connected yet.',
    );
  }

  @override
  Future<void> delete({
    required String storagePath,
  }) {
    throw UnimplementedError(
      'Cloudflare R2 deletion is not connected yet.',
    );
  }
}