// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

// Initialize Turbo
import { Turbo } from "@hotwired/turbo-rails"
Turbo.start()

// Debugging fetch requests
document.addEventListener('turbo:before-fetch-request', (event) => {
  console.log('Turbo fetch request:', event.detail.fetchOptions);
  console.log('Request URL:', event.detail.url);
  console.log('Request Method:', event.detail.fetchOptions.method);
});
