require "rails_helper"
include ActionController::RespondWith

RSpec.describe "ShortLink", :type => :request do
  before(:each) do
    @current_user = create(:user, password: 'password')
    @short_link_params = {
      url: 'http://google.com'
    }
  end
  describe 'user loged in' do
    before(:each) do
      login
      @auth_headers = get_auth_params_from_login_response_headers(response)
    end

    context 'doing allowed action' do
      it 'index return status 200' do
        get short_links_path, headers: @auth_headers
        expect(response).to have_http_status(200)
      end

      it 'show return status 200' do
        short_link = create :short_link
        get short_link_path(short_link), headers: @auth_headers
        expect(response).to have_http_status(200)
      end

      it 'create return status 201' do
        post short_links_path, headers: @auth_headers, params: { short_link: @short_link_params }.to_json
        expect(response).to have_http_status(201)
      end

      it 'update return status 200' do
        short_link = create :short_link, user: @current_user
        put short_link_path(short_link), headers: @auth_headers, params: { short_link: @short_link_params }.to_json
        expect(response).to have_http_status(200)
      end

      it 'delete return status 204' do
        short_link = create :short_link, user: @current_user
        delete short_link_path(short_link), headers: @auth_headers
        expect(response).to have_http_status(204)
      end
    end

    context 'doing not allowed action' do
      it 'update return status 401' do
        user = create :user
        short_link = create :short_link, user: user
        put short_link_path(short_link), headers: @auth_headers, params: { short_link: @short_link_params }.to_json
        expect(response).to have_http_status(401)
      end

      it 'delete return status 401' do
        user = create :user
        short_link = create :short_link, user: user
        delete short_link_path(short_link), headers: @auth_headers
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'user not loged in' do
    before do
      @headers = {
        'CONTENT_TYPE': 'application/json',
        'ACCEPT': 'application/json'
      }

    end
    context 'doing allowed action' do
      it 'show return status 200' do
        short_link = create :short_link
        get short_link_path(short_link), headers: @headers
        expect(response).to have_http_status(200)
      end

      it 'create return status 201' do
        post short_links_path, headers: @headers, params: { short_link: @short_link_params }.to_json
        expect(response).to have_http_status(201)
      end
    end

    context 'doing not allowed action' do
      it 'index return status 401' do
        get short_links_path, headers: @headers
        expect(response).to have_http_status(401)
      end

      it 'update return status 401' do
        short_link = create :short_link
        put short_link_path(short_link), headers: @headers, params: { short_link: @short_link_params }.to_json
        expect(response).to have_http_status(401)
      end

      it 'delete return status 401' do
        short_link = create :short_link
        delete short_link_path(short_link), headers: @headers
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'redirection' do
    it 'return status 301' do
      short_link = create :short_link, @short_link_params
      get short_link_path(short_link)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to short_link.url
    end
  end

  def login
    post '/auth/sign_in/', params: { email: @current_user.email, password: 'password' }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
  end

  def get_auth_params_from_login_response_headers(response)
    client = response.headers['client']
    token = response.headers['access-token']
    expiry = response.headers['expiry']
    token_type = response.headers['token-type']
    uid = response.headers['uid']

    auth_params = {
      'CONTENT_TYPE': 'application/json',
      'ACCEPT': 'application/json',
      'access-token' => token,
      'client' => client,
      'uid' => uid,
      'expiry' => expiry,
      'token-type' => token_type
    }
    auth_params
  end
end
