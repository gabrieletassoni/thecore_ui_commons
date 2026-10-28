# thecore_ui_commons

A Rails engine that provides shared UI artifacts — layouts, assets, view partials, and charting helpers — used across all Thecore-based host applications.

## Language

### Core concepts

**Engine**:
`ThecoreUiCommons::Engine`, a Rails engine mounted into host apps. Provides shared Sprockets assets, layouts, partials, helpers, and controllers with zero host-app boilerplate.
_Avoid_: plugin, gem module

**Shared Assets**:
Sprockets-managed CSS (`thecore_ui_commons.scss`) and JS (`thecore_ui_commons.js`) manifests that host apps include. Split into sub-partials under `app/assets/stylesheets/thecore_ui_commons/` (e.g. `alerts.scss`, `variables.scss`).
_Avoid_: asset bundle, stylesheet bundle

**ECharts Helper**:
A family of plain Ruby classes under `lib/echarts/` that generate Apache ECharts-compatible configuration hashes: `Vector`, `MultipleVectors`, `Binary`, `BinarySeries`, `Speedometer`, `Map`. Used by host apps to build chart config objects server-side before passing them to the frontend.
_Avoid_: chart builder, graph helper

### Layouts and partials

**Devise Session Layout** (`layouts/devise/sessions.html.erb`):
The Devise sign-in page layout. Includes the `_logos` and `_head` partials and loads `devise/sessions.js.erb` + `devise/custom/sessions.scss`.

**Shared Flash Partial** (`shared/_flash.html.erb`):
Renders Bootstrap flash alerts for all alert types. Included by host-app layouts.

**Kaminari Views** (`views/kaminari/`):
Bootstrap-compatible pagination partials that override Kaminari's defaults app-wide.

**Drag-Drop Uploader** (`thecore_utils/_drag_drop_uploader.html.erb`):
A reusable partial for drag-and-drop file uploads.

**Mailer Layout** (`layouts/mailer.html.erb` / `mailer.text.erb`):
Base HTML and text layouts used by ActionMailer in host apps.

**Swagger UI Layout** (`layouts/swagger.html.erb`, `views/info/swagger.html.erb`):
Renders the Swagger UI for API documentation via the `InfoController`.

### Controllers and helpers

**ApplicationController** (`app/controllers/application_controller.rb`):
Base controller providing shared before-actions and helpers for all Thecore controllers.

**InfoController** (`app/controllers/info_controller.rb`):
Serves the Swagger UI documentation page at the engine's info route.

**ThecoreHelper** (`app/helpers/thecore_helper.rb`):
View helper methods shared across all Thecore host apps.

### Swagger versioning

**Version Nav Banner**:
A fixed strip rendered above the `#swagger-ui` div listing all discovered API versions as links, with the current version highlighted. Injected into the page after Version Discovery completes.
_Avoid_: version switcher, version dropdown, version tabs

**Version Discovery**:
Server-side route introspection at application startup — scanning `Rails.application.routes` for paths matching `api/vN/info/swagger` — that determines which API versions the host app exposes. Result is stored in `ThecoreUiCommons.swagger_api_versions` and used to render the Version Nav Banner server-side.
_Avoid_: version detection, version enumeration, version scan, client-side probing

### Assets

**Logo SVGs** (`app/assets/images/`):
`logo.svg` and `app_logo.svg` — default Thecore logo assets overridable by host apps.

**Active Job Monitor** (`app/assets/javascripts/app/active_job_monitor.js`):
JavaScript for polling and displaying background job status in the UI.

**i18n for Devise** (`app/assets/javascripts/devise/sessions.js.erb`):
ERB-templated JS that injects server-side locale values into the Devise sessions page.
