import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["replyForm"]

  showReplyForm(event) {
    event.preventDefault()
    const commentId = event.target.dataset.commentId
    const replyForm = document.getElementById(`reply-form-${commentId}`)
    replyForm.classList.toggle('hidden')
  }
}