class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :delete]
  before_action :login_edit_no, only: :edit

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.create(params_prototype)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(params_prototype)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    if prototype.destroy
      redirect_to root_path
    end
  end

  private

  def params_prototype
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def login_edit_no
    @prototype = Prototype.find(params[:id])
    unless user_signed_in? && @prototype.user_id == current_user.id 
      redirect_to root_path
    end
  end
end
