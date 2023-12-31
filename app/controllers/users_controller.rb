

class UsersController < ApplicationController
  before_action :find_user_by_id, only: %i[edit update show destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path(@user), notice: t(:created)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to users_path(@user), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = t(:deleted)
    redirect_to users_path, status: :see_other
  end

  private

  def user_params
    if current_user.sup_admin?
      params.require(:user).permit(:first_name, :last_name, :email, :user_name, :phone, :role, :password)
    else
      params.require(:user).permit(:first_name, :last_name, :email, :user_name, :phone, :password)
    end

  end

  def find_user_by_id
    @user = User.find(params[:id])
  end
end
