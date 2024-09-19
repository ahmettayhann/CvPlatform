import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import { Cocoon } from "@nathanvda/cocoon"
import "trix"
import "@rails/actiontext"
import "@hotwired/turbo-rails"
import "../controllers"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener("turbolinks:load", function() {
  Cocoon.init(document);
});