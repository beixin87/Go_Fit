class UserCoursesController < ApplicationController
  before_action :set_user_course, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:new, :create, :destroy]

    # GET /user_courses
  # GET /user_courses.json
  def index
    @user_courses = UserCourse.all
  end

  # GET /user_courses/1
  # GET /user_courses/1.json
  def show
  end

  # GET /user_courses/new
  def new
    @user_course = UserCourse.new
  end

  # GET /user_courses/1/edit
  def edit
  end

  # POST /user_courses
  # POST /user_courses.json
  def create

    @user = User.find(current_user.id)
    @course = Course.find(params[:course_id])
    @user_course = UserCourse.new(user_id: current_user.id, course_id: params[:course_id] )

    respond_to do |format|
      if @user_course.save
        @course = Course.find(params[:course_id])

        @user.update_attributes(type: "Student")
        format.html { redirect_to request.referrer, notice: 'Course was successfully added.' }
        format.json { render :show, status: :created, location: @user_course }
      else
        format.html { render :new }
        format.json { render json: @user_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_courses/1
  # PATCH/PUT /user_courses/1.json
  def update
    respond_to do |format|
      if @user_course.update(user_course_params)
        format.html { redirect_to @user_course, notice: 'User course was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_course }
      else
        format.html { render :edit }
        format.json { render json: @user_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_courses/1
  # DELETE /user_courses/1.json
  def destroy
    @user_course.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_course
      @user_course = UserCourse.find(params[:id])
    end

    def student_already_added?(user_id)
          @course = Course.find(params[:course_id])
      @course.user_courses.where(user_id: current_user.id).exists?
    end

    def correct_user
      redirect_to request.referrer unless current_user.admin || !student_already_added?(current_user.id)
    end



    # Never trust parameters from the scary internet, only allow the white list through.
    def user_course_params
      params.require(:user_course).permit(:user_id, :course_id)
    end
end
