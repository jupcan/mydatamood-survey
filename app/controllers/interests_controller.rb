class InterestsController < ApplicationController

  # POST /interests
  def create
    @interest = Interest.new(interest_params)
    if @interest.save
      render json: @interest, status: :created
    else
      render json: @interest.errors, status: :unprocessable_entity
    end
  end

  private
    def interest_params
      params.require(:interest).permit(:user_id, :product_id, :score)
    end
end
