class ExercisesController < ApplicationController
  expose :athlete
  expose :exercises, ->{ athlete.exercises.order("updated_at DESC") }

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
    ## errors?
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
end
