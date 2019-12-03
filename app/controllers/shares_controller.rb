class SharesController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :edit, :update, :destroy]
  before_action :set_share, only: [ :edit, :update, :destroy, :show]
  def index
    @shares = Share.all
  end

  def new
    @share = Share.new
  end

  def create
    @share = Share.new(share_params)
    if @share.save
      NoticeMailer.sendmail_share(@share).deliver_later
      redirect_to shares_path
    else
      render :new
    end
  end

  def show
    @comments = @share.comments
    @comment = @share.comments.build
  end

  def edit;end

   def update;end

   def destroy;end

   private

   def share_params
    params.require(:share).permit(:action)
   end

   def set_share
    @share = Share.find(params[:id])
   end
end