import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select", "managerSelect"]

  connect() {
    // console.log('organisme controller connected')
  }
  change() {
    const organismeId = this.selectTarget.value
    // console.log('managerSelect changed', this.managerSelectTarget)
    const frame = this.managerSelectTarget.closest("turbo-frame")
    if (!organismeId) {
      frame.innerHTML = `
        <label for="project_org_project_manager_id"><em>Sélectionnez d'abord un Organisme</em></label>
        <select name="project[org_project_manager_id]" id="project_org_project_manager_id" class="form-control" disabled>
          <option>Veuillez sélectionner</option>
        </select>`;
    } else {
      frame.src = `/organismes/${organismeId}/org_project_managers_for_select`
    }
  }
}

