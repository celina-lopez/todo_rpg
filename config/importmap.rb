# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "lucide", to: "https://unpkg.com/lucide@latest"
pin "phaser", to: "https://cdn.jsdelivr.net/npm/phaser@3.90.0/dist/phaser.min.js"
pin "game_helpers", to: "game_helpers.js"
