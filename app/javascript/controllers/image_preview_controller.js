// app/javascript/controllers/image_preview_controller.js
import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="image-preview"
export default class extends Controller {
  static targets = ["input", "preview", "actual"];

  connect() {
    console.log('hello preview')
    // this.previewImage();
  }

  previewImage() {
    console.log('Méthode previewImage appelée');
    const input = this.inputTarget;
    const preview = this.previewTarget;
    // const actual = this.actualTarget;

    if (input.files && input.files[0]) {
      const reader = new FileReader();

      reader.onload = function(e) {
        preview.innerHTML = `<div class="d-flex flex-column justify-content-center align-items-center"><p>Prévisualisation du document : </p><img src="${e.target.result}" style="max-width: 200px;">`;

        // if (this.actualTarget) { // Vérifie si l'élément actual existe
        //   actual.innerHTML = ""; // Efface le contenu de l'élément actual
        // }
      };

      reader.readAsDataURL(input.files[0]); // Lit le contenu du fichier
    }
  }
}
