class RespondersController < ApplicationController
  rescue_from ActionController::UnpermittedParameters do |e|
    render json: { message: e.message }, status: :unprocessable_entity
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: 'not found' }, status: :not_found
  end

  def show
    @responder = Responder.find_by!(name: params[:id])
    render :show, status: :ok
  end

  def create
    @responder = Responder.new(create_params)
    if @responder.save
      render :show, status: :created
    else
      render json: { message: @responder.errors }, status: :unprocessable_entity
    end
  end

  def update
    @responder = Responder.find_by!(name: params[:id])
    if @responder.update(update_params)
      render :show
    else
      render json: { message: @responder.errors }, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:responder).permit(:type, :name, :capacity)
  end

  def update_params
    params.require(:responder).permit(:on_duty)
  end
end
