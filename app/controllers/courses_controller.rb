class CoursesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @courses = Course.all
    if params[:query].present?
      @courses = Course.search_by_subject(params[:query])
    end
  end

  def new
    @course = Course.new
  end

  def create
    current_user.courses.create!(
      subject: params['course']['subject'],
      address: params['course']['address']
    )

    redirect_to root_url
  end

  def show
    @course = Course.find(params[:id])
    @booking = Booking.new
    @markers = [{ lat: @course.latitude, lng: @course.longitude }]
  end
end
