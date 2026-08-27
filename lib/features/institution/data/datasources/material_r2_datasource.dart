abstract interface class MaterialR2DataSource {
  Future<String> upload({
    required String storagePath,
    required String fileName,
    required String contentType,
    required List<int> bytes,
  });

  Future<void> delete({
    required String storagePath,
  });
}