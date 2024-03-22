import { Controller } from "@hotwired/stimulus"

import * as React from 'react'
import ReactDOM from "react-dom/client";
import App from "./../app"

export default class extends Controller {
  connect() {
    const root = ReactDOM.createRoot(this.element);
    root.render(<App />);
  }
}
