module ApplicationHelper
  def organisme_collection(form, field, target)
    form.collection_select field, Organisme.all, :id, :name, include_blank: true, class: 'form-select bg-white',  data: { visibility_target: target }
  end

  def new_organisme_field(form, field, target)
    form.text_field field.to_sym, input_html: { data: { visibility_target: target } }, class: 'form-select bg-white'
  end

  # def organisme_users(org)
  #   @organisme = org
  #   @manager_ids = [@organisme.org_manager_id].compact << OrganismeProject.where(organisme_id: @organisme.id).pluck(:org_project_manager_id).uniq
  #   @org_project_managers = User.where(id: @manager_ids.flatten)
  # end

  def organisme(user)
    Organisme.find_by(org_manager_id: user.id)
  end
end
