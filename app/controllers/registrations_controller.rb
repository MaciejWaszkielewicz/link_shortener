class RegistrationsController < DeviseTokenAuth::RegistrationsController

  def_param_group :register do
    param :user, Hash do
      param :email, String, desc: 'User email'
      param :password, String, desc: 'User password'
      param :password_confirmation, String, desc: 'User password confirmation'
    end
  end

  def_param_group :user do
    param :data, Hash do
      param :email, String, desc: 'User email'
      param :uid, String, desc: 'User unique id'
      param :id, Integer, desc: 'User id'
      param :provider, String, desc: 'Authentication method'
      param :name, String, desc: 'User name'
      param :nickname, String, desc: 'User nickname'
      param :image, String, desc: 'User image'
    end
  end

  api :POST, '/auth/', 'Sign up'
  returns :user, code: 200, desc: 'User attributes'
  param_group :register
  def create
    # doc only
  end
end