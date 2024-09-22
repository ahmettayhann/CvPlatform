import "../stylesheets/application.scss"

   import "@hotwired/turbo-rails"
   import * as ActiveStorage from "@rails/activestorage"
   import "channels"
   import { Application } from "@hotwired/stimulus"
   import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers"
   import "cocoon-js"
   import "trix"
   import "@rails/actiontext"

   Rails.start()
   Turbolinks.start()
   // Start ActiveStorage
   ActiveStorage.start()

   // Initialize Stimulus application
   const application = Application.start()
   const context = require.context("../controllers", true, /_controller\.js$/)
   application.load(definitionsFromContext(context))

   // Start Turbo
   import { Turbo } from "@hotwired/turbo-rails"
   Turbo.session.drive = false