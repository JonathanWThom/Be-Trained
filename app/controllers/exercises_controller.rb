class ExercisesController < ApplicationController
  expose :athlete
  expose :exercises, ->{ athlete.exercises.order("updated_at DESC") }
  include ApplicationHelper
  helper_method :sort_column, :sort_direction

  def new
    @exercise = athlete.exercises.new
    respond_to do |format|
      format.js
    end
  end

  def create
    exercise = athlete.exercises.create(exercise_params)
    respond_to do |format|
      format.js
    end
  end

  def edit
    @exercise = Exercise.find(params[:id])
    respond_to do |format|
      format.js { render :new }
    end
  end

  def update
    @exercise = Exercise.find(params[:id])
    @exercise.update(exercise_params)
    respond_to do |format|
      format.js { render :create }
    end
  end

  def show
    @exercise = Exercise.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @exercise = Exercise.find(params[:id])
    @exercise.destroy
    respond_to do |format|
      format.js
    end
  end

  def cancel
    respond_to do |format|
      format.js { render :create }
    end
  end

  def hide_history
    @exercise = Exercise.find(params[:exercise_id])
    respond_to do |format|
      format.js
    end
  end

  private

  def exercise_params
    params.require(:exercise).permit(:name, :record, :date, :unit)
  end

  def sort_column
    Exercise.column_names.include?(params[:sort]) ? params[:sort] : "date"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
