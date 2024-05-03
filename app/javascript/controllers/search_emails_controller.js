import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "select"]

  connect() {
    this.inputTarget.addEventListener("input", () => this.searchManager());
    this.selectTarget.addEventListener("change", () => this.updateInputField());
  }

  searchManager() {
    const email = this.inputTarget.value.trim();
    const organismeId = this.element.dataset.organismeId;

    fetch(`/organismes/${organismeId}/search_manager?email=${email}`, {
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
    })
    .then(response => {
      if (!response.ok) throw new Error('Network response was not ok');
      return response.json();
    })
    .then(data => this.displayResults(data))
    .catch(error => console.error('Error:', error));
  }

  displayResults(data) {
    this.selectTarget.innerHTML = '';
    this.selectTarget.add(new Option('Sélectionnez un manager', '', true, true));

    data.users.forEach(user => {
      let option = new Option(user.email, user.id);
      this.selectTarget.add(option);
    });
  }

  updateInputField() {
    const selectedOption = this.selectTarget.options[this.selectTarget.selectedIndex];
    this.inputTarget.value = selectedOption.text;
  }
}
