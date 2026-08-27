class MaterialFile {
  const MaterialFile({
    required this.fileName,
    required this.storagePath,
    required this.contentType,
    required this.sizeBytes,
  });

  final String fileName;
  final String storagePath;
  final String contentType;
  final int sizeBytes;
}