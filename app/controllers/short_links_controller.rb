class ShortLinksController < ApplicationController
  def_param_group :short_link do
    param :slug, String, desc: 'Slug that will be used in short link (if nil then it will be generated)'
    param :url, String, required: true, desc: 'Url that should start with http/https protocol'
  end

  def_param_group :short_link_neasted do
    param :short_link, Hash do
      param :slug, String, desc: 'Slug that will be used in short link'
      param :url, String, required: true, desc: 'Url to redirect'
    end
  end

  before_action :set_short_link, only: [:show, :update, :destroy]

  # GET /short_links
  api :GET, '/short_links/', 'Shows short links assigned to user'
  returns array_of: :short_link, code: 200, desc: 'All short links assigned to user'
  def index
    authorize! :index, ShortLink
    @short_links = ShortLink.where(user: current_user)
    render json: @short_links
  end

  # GET /short_links/1
  api :GET, '/short_links/<slug: string>', 'Shows short link'
  returns :short_link, code: 200, desc: 'Single short link'
  def show
    respond_to do |format|
      format.json { render json: @short_link }
      format.html { redirect_to @short_link.url }
    end
  end

  # POST /short_links
  api :POST, '/short_links/', 'Create a new short link'
  returns :short_link, code: 200, desc: 'Created short link'
  param_group :short_link_neasted
  def create
    @short_link = ShortLink.new(short_link_params)
    @short_link.user = current_user
    authorize! :create, @short_link
    if @short_link.save
      render json: @short_link, status: :created, location: @short_link
    else
      render json: @short_link.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /short_links/1
  api :PUT, '/short_links/<slug: string>/', 'Update short link'
  returns :short_link, code: 200, desc: 'Updated short link'
  param_group :short_link_neasted
  def update
    authorize! :update, @short_link
    if @short_link.update(short_link_params)
      render json: @short_link
    else
      render json: @short_link.errors, status: :unprocessable_entity
    end
  end

  # DELETE /short_links/1
  api :DESTROY, '/short_links/<slug: string>/', 'Destroy short link'
  def destroy
    authorize! :destroy, @short_link
    @short_link.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_short_link
      @short_link = ShortLink.find_by(slug: params[:slug])
    end

    # Only allow a list of trusted parameters through.
    def short_link_params
      params.require(:short_link).permit(:slug, :url)
    end
end
