// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import 'jquery'
import '@popperjs/core'
import '@nathanvda/cocoon'
import 'bootstrap/js/dist/dropdown'
import 'packs/utilities/answers.js'
import 'packs/utilities/question.js'
import 'packs/utilities/direct_uploads.js'
import 'packs/utilities/votes.js'

Rails.start()
Turbolinks.start()
ActiveStorage.start()
