puts "Loading ThecoreUiCommons seeds"

Thecore::Seed.save_setting :importer, :import_from_folder, "tmp/imports"
Thecore::Seed.save_setting :importer, :extension, "txt"

Thecore::Seed.save_setting :theme, :text_color, "#FFEAD0"
Thecore::Seed.save_setting :theme, :accents_color, "#F76F8E"
Thecore::Seed.save_setting :theme, :background_color, "#96616B"
Thecore::Seed.save_setting :theme, :main_color, "#37505C"
Thecore::Seed.save_setting :theme, :shadows_color, "#113537"

Thecore::Seed.save_setting :theme, :neutral_color, "#999999"
Thecore::Seed.save_setting :theme, :success_color, "#37BC9B"
Thecore::Seed.save_setting :theme, :info_color, "#CCCCCC"
Thecore::Seed.save_setting :theme, :danger_color, "#E9573F"
Thecore::Seed.save_setting :theme, :warning_color, "#F6BB42"