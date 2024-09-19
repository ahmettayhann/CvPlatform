import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

export default class extends Controller {
  static targets = [ "input" ]

  perform() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      Turbo.visit(`${this.element.action}?search=${this.inputTarget.value}`, { frame: "resumes-list" })
    }, 200)
  }
}