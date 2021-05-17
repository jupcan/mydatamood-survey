class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordNotUnique, :with => :render_not_unique_response
    rescue_from ActiveRecord::NotNullViolation, :with => :render_not_null_violation_response

    def render_unprocessable_entity_response(exception)
        render json: exception.record.errors, status: :unprocessable_entity
    end

    def render_not_found_response(exception)
        render json: { error: exception.message }, status: :not_found
    end

    def render_not_unique_response(exception)
        render json: { error: exception.message }, status: :unprocessable_entity
    end

    def render_not_null_violation_response(exception)
        render json: { error: exception.message }, status: :unprocessable_entity
    end
end
