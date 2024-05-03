import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["chooseOrg", "createOrg", "chooseManager", "createManager", "button"]

  connect() {
    // Initial setup if needed
  }

  toggle() {
    const buttonState = this.buttonTarget.textContent;
    if (buttonState.includes("Choisir un Organisme Existant")) {
      this.chooseOrgTarget.classList.remove('hidden');
      this.createOrgTarget.classList.add('hidden');
      this.buttonTarget.textContent = "Créer un Nouvel Organisme";
    } else {
      this.chooseOrgTarget.classList.add('hidden');
      this.createOrgTarget.classList.remove('hidden');
      this.buttonTarget.textContent = "Choisir un Organisme Existant";
    }
  }

  toggleManager() {
    const buttonText = this.buttonTargets.find(btn => btn.id === 'toggleButtonManager').textContent;
    if (buttonText.includes("Choisir un Manager")) {
      this.chooseManagerTarget.classList.remove('hidden');
      this.createManagerTarget.classList.add('hidden');
      this.buttonTargets.find(btn => btn.id === 'toggleButtonManager').textContent = "Créer un Nouveau Manager";
    } else {
      this.chooseManagerTarget.classList.add('hidden');
      this.createManagerTarget.classList.remove('hidden');
      this.buttonTargets.find(btn => btn.id === 'toggleButtonManager').textContent = "Choisir un Manager";
    }
  }
}
