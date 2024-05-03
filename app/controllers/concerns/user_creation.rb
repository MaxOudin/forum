module UserCreation
  extend ActiveSupport::Concern

  def find_or_create_user(params_email, params_id)
    if params_email.present?
      u = User.find_or_create_by(email: params_email) do |user|
        user.password = 'password'
        # user.password = SecureRandom.hex(10)
        user.role = :org_program_manager
      end
      u.id
    else
      User.find(params_id)
    end
  end
end
