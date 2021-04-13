class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::MimeResponds

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { render json: { message: 'Unauthorizated' }, status: 401 }
    end
  end
end
