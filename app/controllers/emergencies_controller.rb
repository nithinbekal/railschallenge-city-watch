class EmergenciesController < ApplicationController
  def show
    @emergency = Emergency.find_by!(code: params[:id])
  end

  def create
    @emergency = Emergency.new(create_params)
    if @emergency.save
      render :show, status: :created
    else
      render json: { message: @emergency.errors }, status: :unprocessable_entity
    end
  end

  def update
    @emergency = Emergency.find_by!(code: params[:id])
    if @emergency.update(update_params)
      render :show, status: :ok
    else
      render json: { message: @emergency.errors }
    end
  end

  private

  def create_params
    params.require(:emergency).permit(:code, :fire_severity, :medical_severity, :police_severity)
  end

  def update_params
    params.require(:emergency).permit(:fire_severity, :medical_severity, :police_severity, :resolved_at)
  end
end
