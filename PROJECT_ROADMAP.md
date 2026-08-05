# CourseMind Project Roadmap

---

# Version

**Current Version:** 2.0 (Rebuild)

---

# Project Vision

CourseMind is an AI-powered academic learning platform that helps tertiary students learn smarter by transforming institution-provided academic resources into structured AI-assisted learning experiences.

Unlike a traditional Learning Management System (LMS), CourseMind does not rely on lecturers to teach through the platform. Institutions provide academic resources, while AI organizes, teaches, quizzes, and supports students throughout their learning journey.

---

# Core Objectives

- Deliver AI-powered learning experiences.
- Centralize academic resources.
- Support offline learning.
- Provide secure academic marketplaces.
- Create a scalable enterprise application.

---

# Technology Stack

## Frontend

- Flutter

## Programming Language

- Dart

## State Management

- Riverpod

## Backend

- Firebase

### Firebase Services

- Firebase Authentication
- Cloud Firestore
- Firebase Cloud Messaging
- Firebase Analytics
- Firebase Crashlytics

## Cloud Storage

- Cloudflare R2

## Routing

- GoRouter

## Networking

- Dio

---

# Project Architecture

```text
lib/

├── app/
├── core/
├── shared/
├── features/
└── main.dart
```

---

# Feature Architecture

```text
features/

├── public/
│
├── student/
│
└── institution/
```

---

# Public Module

Responsible for:

- Splash
- Authentication
- Profile
- Settings

---

# Student Module

Responsible for:

- Dashboard
- Courses
- AI Tutor
- Library
- Marketplace

---

# Institution Module

Responsible for:

- Dashboard
- Programmes
- Administration
- Settings

---

# AI Tutor Philosophy

Institutions provide academic resources.

↓

AI analyzes the resources.

↓

AI creates structured lesson plans.

↓

Students learn through AI.

↓

AI generates quizzes.

↓

Students interact with AI through chat.

↓

Students access the original learning resources whenever needed.

---

# Development Standards

Every implementation must follow these rules.

## Rule 1

Every file begins with the CourseMind documentation header.

---

## Rule 2

Every implementation is divided into logical sections.

---

## Rule 3

Every phase ends with:

- Architecture review
- Implementation review
- Flutter Analyze
- Error resolution
- Progress update

---

## Rule 4

No analyzer warnings or errors move into the next phase.

---

## Rule 5

No feature begins until its foundation has been completed.

---

## Rule 6

Major architectural decisions are documented.

---

# Development Workflow

Every feature follows this sequence.

1. Architecture
2. UI
3. State Management
4. Backend Integration
5. Testing
6. Optimization
7. Documentation

---

# Project Phases

## Phase 0

### Enterprise Architecture

Status:

✅ Complete

Completed:

- Folder Structure
- Core Architecture
- Shared Module
- Feature Architecture
- Technology Stack

---

## Phase 1

### Project Foundation

Status:

✅ Complete

Completed:

- Dependencies
- Analysis & Linting
- Environment Configuration
- Router Foundation
- Riverpod Foundation
- Firebase Foundation
- Storage Foundation

---

## Phase 2

### Public Module

Status:

⬜ Pending

Modules:

- Splash
- Authentication
- Profile
- Settings

---

## Phase 3

### Student Module

Status:

⬜ Pending

Modules:

- Dashboard
- Courses
- AI Tutor
- Library
- Marketplace

---

## Phase 4

### Institution Module

Status:

⬜ Pending

Modules:

- Dashboard
- Programmes
- Administration
- Settings

---

## Phase 5

### Application Testing

Status:

⬜ Pending

Includes:

- Unit Testing
- Widget Testing
- Integration Testing
- Performance Optimization

---

## Phase 6

### Production Release

Status:

⬜ Pending

Includes:

- Final QA
- Security Review
- Store Preparation
- Release Build

---

# Progress Tracker

| Phase | Status |
|---------|--------|
| Phase 0 | ✅ Complete |
| Phase 1 | ✅ Complete |
| Phase 2 | ⬜ Pending |
| Phase 3 | ⬜ Pending |
| Phase 4 | ⬜ Pending |
| Phase 5 | ⬜ Pending |
| Phase 6 | ⬜ Pending |

---

# Current Milestone

**Next Objective**

Begin implementation of the **Public Module** starting with the Splash experience.

---

# Notes

This document should be updated whenever:

- A development phase is completed.
- New architectural decisions are made.
- The technology stack changes.
- Major features are added or removed.

It serves as the project's single source of truth for development progress.