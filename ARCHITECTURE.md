# CourseMind System Architecture

---

# Version

Architecture Version: 2.0

---

# Purpose

This document defines the technical architecture of CourseMind.

It serves as the primary reference for the project's software
design, coding standards, module organization, infrastructure,
and architectural decisions.

---

# System Philosophy

CourseMind is an AI-powered academic learning platform.

Institutions provide trusted academic resources.

Artificial Intelligence transforms those resources into structured
learning experiences.

Students learn through AI while maintaining access to the original
academic materials.

---

# High-Level Architecture

```
Presentation
        │
        ▼
Application Layer
        │
        ▼
Domain Layer
        │
        ▼
Infrastructure Layer
```

---

# Folder Architecture

```
lib/

├── app/
├── core/
├── shared/
├── features/
└── main.dart
```

---

# App Module

Purpose

Application bootstrap.

Contains

- Router
- Constants
- Theme
- Application configuration

---

# Core Module

Purpose

Shared infrastructure.

Contains

- Configuration
- Providers
- Services
- Network
- Errors
- Utilities
- Extensions

---

# Shared Module

Purpose

Reusable UI and application components.

Contains

- Widgets
- Components
- Helpers
- Shared models

---

# Features Module

Purpose

Business functionality.

Organized by user domain.

```
features/

├── public/
├── student/
└── institution/
```

---

# Public Module

Responsibilities

- Splash
- Authentication
- Profile
- Settings

---

# Student Module

Responsibilities

- Dashboard
- Courses
- AI Tutor
- Library
- Marketplace

---

# Institution Module

Responsibilities

- Dashboard
- Programmes
- Administration
- Settings

---

# AI Tutor Architecture

```
Institution Uploads

Course Outline

Handouts

Learning Materials

        │
        ▼

Artificial Intelligence

        │

Creates

Lesson Plan

        │

Topic Structure

        │

AI Teaching

        │

Student Questions

        │

AI Responses

        │

Quiz Generation

        │

Learning Progress
```

---

# Storage Architecture

```
Institution

        │

Uploads

        │

Cloudflare R2

        │

Metadata

        │

Firestore

        │

Student Access

        │

Library

        │

Offline Storage
```

---

# Firebase Responsibilities

Authentication

- Login
- Registration
- Session

Firestore

- Metadata
- User Data
- Course Data

Messaging

- Notifications

Analytics

- User Metrics

Crashlytics

- Crash Reporting

---

# Riverpod Architecture

Global Providers

```
App Provider

Authentication Provider

Theme Provider

Navigation Provider

Storage Provider
```

Feature-specific providers remain inside each feature.

---

# Routing

Navigation uses GoRouter.

Centralized inside

```
app/router/
```

Every route must be defined in

```
route_names.dart
```

No hardcoded route strings.

---

# Storage Strategy

Cloud

Cloudflare R2

Purpose

Academic Resources

- PDFs
- Images
- Videos

Local

Device Storage

Purpose

Offline Learning

- Downloaded Handouts
- Downloaded Tutorials
- Cache

---

# Security Principles

Authentication required for protected resources.

Premium content requires purchase verification.

Cloud storage should never be accessed directly from feature modules.

---

# Development Standards

Every Dart file must contain:

- Documentation header
- Enterprise section headers

Every implementation must:

- Pass flutter analyze
- Pass architecture review
- Pass implementation review

---

# Coding Standards

Use:

- Riverpod
- GoRouter
- Clean Architecture
- Dependency Injection

Avoid:

- Hardcoded routes
- Hardcoded colors
- Hardcoded strings
- Business logic inside UI

---

# Future Expansion

Planned additions

- AI Learning Analytics
- Institution Verification
- AI Study Planner
- AI Exam Prediction
- Discussion Communities
- Multi-language Support

---

# Architecture Status

Current Status

Version 2.0

Approved

Ready for Feature Development.