import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "printer", "mode", "mode2" ]

  connect() {
    this.update();
  }

  update() {
    const printerId = this.printerTarget.value;

    fetch(`filters.json?printerId=${printerId}`)
    .then(response => response.json()) 
    .then(data => {
      this.modeTarget.textContent = data.texto
      this.mode2Target.textContent = data.queue
    })
  }
}
