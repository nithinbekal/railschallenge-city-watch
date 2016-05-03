class EmergenciesController < ApplicationController
  def create
    @emergency = Emergency.new(create_params)
    if @emergency.save
      render :show, status: :created
    else
      render json: { message: @emergency.errors }, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:emergency).permit(:code, :fire_severity, :medical_severity, :police_severity)
  end
end
