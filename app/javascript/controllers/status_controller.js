import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "printer", "mode", "mode2" ]

  connect() {
    console.log("Funciona correctamente!!!!!!!!!!!!!!!!!!!!!!!")
    console.log(this.printerTarget)
    console.log(this.modeTarget)
  }

  update() {
    const printerId = this.printerTarget.value;

    fetch(`filters.json?printerId=${printerId}`)
    .then(response => response.json()) 
    .then(data => {
      console.log("Entro")
      console.log(data.texto+" texto")
      this.modeTarget.textContent = data.texto
      this.mode2Target.textContent = data.queue
    })
    
    console.log("Me voy")
  }
}
