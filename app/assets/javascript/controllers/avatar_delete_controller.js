import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form"]

  connect() {
    this.formTarget.addEventListener("submit", this.handleSubmit.bind(this))
  }

  handleSubmit(event) {
    event.preventDefault()
    if (confirm("Are you sure you want to remove your avatar?")) {
      fetch(this.formTarget.action, {
        method: 'DELETE',
        headers: {
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        credentials: 'same-origin'
      }).then(response => {
        if (response.ok) {
          window.location.reload()
        } else {
          alert('There was an error removing the avatar.')
        }
      })
    }
  }
}