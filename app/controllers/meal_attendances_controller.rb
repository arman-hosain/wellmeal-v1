class MealAttendancesController < ApplicationController
  before_action :find_attendance_by_id, only: %i[edit update show destroy]
  before_action :authenticate_user!
  load_and_authorize_resource
  def index
    @today_lunch_count=MealAttendance.where("DATE(meal_date)=? AND meal_type=?", Date.today,0).distinct.count('user_id')
    @today_snack_count=MealAttendance.where("DATE(meal_date)=? AND meal_type=?", Date.today,1).distinct.count('user_id')

    new_query={}
    new_query.merge!(meal_type: params[:category]) if params[:category].present? && params[:category]!=''
    new_query.merge!(meal_date: params[:search_date]) if params[:search_date].present? && params[:search_date]!=''

    new_query.compact_blank
    new_query.compact!

    @MealAttendances=MealAttendance.where(new_query)
    @MealAttendances=@MealAttendances.joins(:user).where("first_name LIKE ?", "%#{params[:search].delete(' ')}%") if params[:search].present? && params[:search]!=''
  end

  def new
    @MealAttendance = MealAttendance.new
    @lunch_status=MealAttendance.where(user_id: current_user.id, meal_type: 0, meal_date: Date.today).exists?
    @snack_status=MealAttendance.where(user_id: current_user.id, meal_type: 1, meal_date: Date.today).exists?
  end

  def create
    @MealAttendance = MealAttendance.new(meal_attendance_params)
    @MealAttendance.user_id = current_user.id
    @MealAttendance.meal_date= Date.today


    user_attendance = MealAttendance.where(user_id: current_user.id, meal_type: @MealAttendance.meal_type, meal_date: Date.today).exists?
    if user_attendance
      redirect_to meal_attendances_path, notice: t(:duplicate_attendance)
    elsif @MealAttendance.save
      redirect_to menus_path, notice: t(:created)
    else
      redirect_to meal_attendances_path, notice: t(:invalid_attendance)
    end
  end

  def show; end

  def edit; end


  def destroy
    @MealAttendance.destroy
    flash[:notice] = t(:deleted)
    redirect_to meal_attendances_path, status: :see_other
  end

  private

  def meal_attendance_params
    params.require(:meal_attendance).permit(:meal_type, :meal_date)
  end

  def find_attendance_by_id
    @MealAttendance = MealAttendance.find(params[:id])
  end
end
