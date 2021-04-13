class SessionsController < DeviseTokenAuth::SessionsController

  def_param_group :auth do
    param :user, Hash do
      param :email, String, required: true, desc: 'User email'
      param :password, String, required: true, desc: 'User password'
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

  api :POST, '/auth/sign_in', 'Sign in'
  returns :user, code: 200, desc: 'For authoryzation use header params: [\'access-token\', \'client\', \'uid\']'
  param_group :auth
  def create
    # doc only
  end
end