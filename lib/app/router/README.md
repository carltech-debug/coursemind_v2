# App Router

---

## Module

Application Routing

---

## Purpose

The Router module is responsible for all application navigation.

It provides a centralized navigation system using **GoRouter** and
ensures that every screen transition follows a consistent,
maintainable architecture.

---

## Responsibilities

- Register application routes.
- Configure GoRouter.
- Protect authenticated routes.
- Handle navigation redirection.
- Support deep linking.
- Support role-based navigation.

---

## Files

| File | Responsibility |
|------|----------------|
| app_router.dart | Creates the global GoRouter instance. |
| app_routes.dart | Registers all application routes. |
| route_names.dart | Defines every route path constant. |
| route_guards.dart | Handles navigation protection. |

---

## Future Work

- Splash navigation
- Authentication redirects
- Student navigation
- Institution navigation
- Error routes
- Deep linking
- Route observers

---

## Status

🚧 Foundation Complete

Implementation will begin during the Public Module.