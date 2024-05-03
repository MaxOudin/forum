class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  prepend_before_action :require_no_authentication, only: [:cancel]
  prepend_before_action :authenticate_scope!, only: [:new, :create, :edit, :update, :destroy]

  # before_action :authenticate_user! # Assure que l'utilisateur est authentifié

  def index
    @users = User.all
    authorize @users # Vérifie les autorisations avec Pundit
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  # def create
  #   @user = User.new(user_params)
  #   authorize @user # Vérifie les autorisations avec Pundit

  #   if @user.save
  #     redirect_to @user, notice: 'User was successfully created.'
  #   else
  #     render :new
  #   end
  # end
  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.admin? || resource.admin_ue? || resource.program_manager? || resource.tei_manager?
        if is_flashing_format?
          set_flash_message :notice, :signed_up if is_navigational_format?
        end
        # sign_up(resource_name, resource)
        respond_with resource, location: users_path
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update(user_params)
      respond_to do |format|
        format.html { redirect_to users_path, notice: 'Email mis à jour avec succès.' }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end
  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def require_no_authentication
    if current_user && !current_user.admin?
      redirect_to root_path, alert: "Vous êtes déjà connecté."
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :role])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
