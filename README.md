# thecore_ui_commons

A Rails engine providing shared UI artifacts for [Thecore](https://github.com/gabrieletassoni/thecore/tree/release/3)-based host applications.

## What it provides

- **Layouts** — Devise session page, Swagger UI, mailer (HTML + text)
- **Partials** — Bootstrap flash alerts, Kaminari pagination, drag-drop file uploader, logos
- **ECharts helpers** — Ruby classes for building Apache ECharts config server-side (`Vector`, `MultipleVectors`, `Binary`, `BinarySeries`, `Speedometer`, `Map`)
- **Swagger versioning** — `/info/swagger/:version` with automatic version discovery from mounted routes
- **Assets** — shared CSS/JS manifests, Active Job monitor, Devise i18n injection

## Installation

Add to your host app's `Gemfile`:

```ruby
gem 'thecore_ui_commons', '~> 3.0'
```

The engine mounts automatically. No configuration required.

## Swagger UI

The Swagger UI is available at `/info/swagger` (redirects to `/info/swagger/v2`).

If your app mounts `model_driven_api`, the engine discovers all available API versions at startup by scanning `Rails.application.routes` for paths matching `api/vN/info/swagger`. A version nav banner appears automatically above the Swagger UI — no configuration needed.
