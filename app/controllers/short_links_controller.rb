class ShortLinksController < ApplicationController
  before_action :set_short_link, only: [:show, :update, :destroy]

  # GET /short_links
  def index
    authorize! :index, ShortLink
    @short_links = ShortLink.where(user: current_user)
    render json: @short_links
  end

  # GET /short_links/1
  def show
    respond_to do |format|
      format.json { render json: @short_link }
      format.html { redirect_to @short_link.url }
    end
  end

  # POST /short_links
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
  def update
    authorize! :update, @short_link
    if @short_link.update(short_link_params)
      render json: @short_link
    else
      render json: @short_link.errors, status: :unprocessable_entity
    end
  end

  # DELETE /short_links/1
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
