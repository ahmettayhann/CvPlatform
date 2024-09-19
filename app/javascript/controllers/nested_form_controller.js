import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["template", "add_item"]

  connect() {
    console.log("Nested form controller connected")
  }

  add_association(event) {
    event.preventDefault()
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    this.add_itemTarget.insertAdjacentHTML('beforebegin', content)
  }

  remove_association(event) {
    event.preventDefault()
    const item = event.target.closest(".nested-fields")
    item.querySelector("input[name*='_destroy']").value = 1
    item.style.display = 'none'
  }
}