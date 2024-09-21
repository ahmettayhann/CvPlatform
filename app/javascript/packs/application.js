import Rails from "@rails/ujs"
import "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers"
import "stylesheets/application"
import "cocoon-js"
import { Turbo } from "@hotwired/turbo-rails"
Turbo.start()

Rails.start()
ActiveStorage.start()

// Initialize Stimulus application
const application = Application.start()
const context = require.context("../controllers", true, /\.js$/)
application.load(definitionsFromContext(context))
require("trix")
require("@rails/actiontext")