class ApplicationController < ActionController::Base
  rescue_from ActionController::UnpermittedParameters do |e|
    render json: { message: e.message }, status: :unprocessable_entity
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: 'not found' }, status: :not_found
  end

  private

  def action_missing(m)
    render json: { message: 'page not found' }, status: :not_found
  end
end
