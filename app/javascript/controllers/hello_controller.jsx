import { Controller } from "@hotwired/stimulus"

import * as React from 'react'
import * as ReactDOM from "react-dom";
import App from "./../app"

export default class extends Controller {
  connect() {
    ReactDOM.render(<App />, this.element);
  }
}
