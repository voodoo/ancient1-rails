import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Comment controller connected")
  }

  showReplyForm(event) {
    event.preventDefault()
    const url = event.currentTarget.getAttribute('href')
    fetch(url, {
      headers: {
        'Accept': 'text/vnd.turbo-stream.html'
      }
    })
      .then(response => response.text())
      .then(html => {
        Turbo.renderStreamMessage(html)
      })
  }
}