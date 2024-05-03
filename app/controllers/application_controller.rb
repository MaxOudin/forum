class ApplicationController < ActionController::Base
  before_action :authenticate_user!, if: :devise_controller?
  include Pundit::Authorization

  before_action :configure_permitted_parameters, if: :devise_controller?

  # # Pundit: allow-list approach
  # after_action :verify_authorized, except: :index, unless: :skip_pundit?
  # after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[role first_name last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[role first_name last_name])
  end

  # after_action :verify_authorized, except: :index, unless: :skip_pundit?
  # after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Gestion des exceptions pour les politiques non autorisées
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  # Méthode de secours pour gérer les politiques non autorisées
  # def user_not_authorized
  #   flash[:alert] = "Vous n'êtes pas autorisé à effectuer cette action."
  #   redirect_to(request.referrer || root_path)
  # end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def changing_to_org_program_manager?
    params[:user] && params[:user][:role] == 'org_program_manager'
  end
end
