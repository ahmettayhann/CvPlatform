import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "form"]

  connect() {
    this.performSearch = this.debounce(this.performSearch.bind(this), 300)
  }

  perform() {
    this.performSearch()
  }

  clear(event) {
    event.preventDefault()
    this.inputTarget.value = ""  // Clear the search input
    this.formTarget.requestSubmit()  // Submit the form to reload all results
  }

  performSearch() {
    this.formTarget.requestSubmit()  // Trigger form submission on input change
  }

  debounce(func, wait) {
    let timeout
    return function executedFunction(...args) {
      const later = () => {
        clearTimeout(timeout)
        func(...args)
      }
      clearTimeout(timeout)
      timeout = setTimeout(later, wait)
    }
  }
}
