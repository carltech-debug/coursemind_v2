# Storage Services

---

## Module

Core Storage Infrastructure

---

## Purpose

The Storage module provides a unified storage architecture for CourseMind.

Instead of allowing feature modules to communicate directly with storage providers, every storage request passes through a centralized abstraction layer.

---

## Architecture

```text
Student Feature
        │
        ▼
Storage Service
        │
 ┌──────┴────────┐
 ▼               ▼
Cloud Storage   Local Storage
(R2)            (Device)
```

---

## Folder Structure

```text
storage/
│
├── cloud/
│   └── cloudflare_r2_service.dart
│
├── local/
│   └── local_storage_service.dart
│
├── storage_service.dart
└── README.md
```

---

## Responsibilities

### Storage Service

- Storage abstraction
- Dependency injection
- Provider independence

### Cloudflare R2

- Upload
- Download
- Signed URLs
- Object management

### Local Storage

- Offline documents
- Cache management
- Downloaded resources

---

## Future Expansion

Potential additions include:

- File encryption
- Storage quota monitoring
- Background synchronization
- Automatic cleanup
- Version management

---

## Status

🚧 Foundation Complete

Implementation will begin during the Library and Marketplace modules.