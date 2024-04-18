class SocialsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_social, only: [:show, :edit, :update, :destroy]

  def index
    @socials = Social.all
  end

  def show
  end

  def new
    @social = Social.new
  end

  def create
    @social = Social.new(social_params)
    if @social.save
      redirect_to organismes_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @social.update(social_params)
      redirect_to organismes_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @social.destroy
    redirect_to organismes_path, status: :see_other
  end

  private

  def social_params
    params.require(:social).permit(:name, :youtube_channel, :youtube_video_url, :x_twitter, :facebook_page_url, :linkedin_page_url, :instagram_page_url)
  end

  def set_social
    @social = Social.find(params[:id])
  end

  def set_user
    @user = current_user
  end

end
