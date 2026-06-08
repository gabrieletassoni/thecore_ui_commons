# No direct dependency on model_driven_api

`thecore_ui_commons` scans `Rails.application.routes` for paths matching `api/vN/info/swagger` — a pattern provided by `model_driven_api` in host apps. We explicitly chose not to declare `model_driven_api` as a dependency.

Two options were considered and rejected:

- **Replace `thecore_backend_commons` with `model_driven_api`** — impossible: `model_driven_api` itself depends on `thecore_backend_commons`, so `thecore_backend_commons` would still be loaded transitively. Nothing is gained.
- **Add `model_driven_api` alongside `thecore_backend_commons`** — wrong: not every host app that uses `thecore_ui_commons` uses `model_driven_api`. Some host apps have no API layer at all. Declaring the dependency would force `model_driven_api` on apps that don't need it.

The Swagger version discovery is designed to be opportunistic: if matching routes are present (from `model_driven_api` or any other source), the Version Nav Banner renders. If not, nothing breaks. This makes `thecore_ui_commons` mountable in any Thecore host app regardless of its API layer.
