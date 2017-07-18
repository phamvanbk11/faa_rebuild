class V1::CoursesController < V1::ApiController
  before_action :load_course, only: [:edit, :update, :destroy]

  def index
    if course_id = params[:on_slider_index]
      Course.transaction do
        Course.update on_slider_index: false
        Course.update course_id, on_slider_index: true
      end
    end
    on_slider_index = Course.find_by(on_slider_index: true).id
    courses = Course.page(page).per Settings.admin_page.per_page
    response_success nil, {courses: courses, page: page,
      on_slider_index: on_slider_index, pages: courses.total_pages}
  end

  def create
    @course = Course.new course_params
    if @course.save
      response_success t(".save_success"), @course
    else
      response_error t(".save_failed"), @course.errors.full_messages
    end
  end

  def edit
    response_success nil, {course: @course, statuses: Course.statuses.keys,
      images: @course.images}
  end

  def update
    if @course.update_attributes(course_params)
      response_success t(".save_success"), @course
    else
      response_error t(".save_failed"), @course.errors.full_messages
    end
  end

  def destroy
    if @course.destroy
      response_success nil, @course
    else
      response_error t(".delete_failed"), nil
    end
  end

  private

  def course_params
    params.permit :name, :description, :status, :technique, :cost, :content,
      :on_slider_index, images_attributes: [:id, :url]
  end

  def load_course
    return if @course = Course.find_by(id: params[:id])
    response_not_found t(".not_found"), nil
  end
end
