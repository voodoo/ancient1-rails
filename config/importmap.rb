pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true

# Add this new pin
pin_all_from "app/javascript/controllers", under: "controllers"