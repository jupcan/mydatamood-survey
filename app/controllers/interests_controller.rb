class InterestsController < ApplicationController
  # POST /interests
  def create
    user = User.find_or_create_by(id: params[:user_id])
    @interest = user.interests.new(interest_params)
    if @interest.save
      render json: @interest, status: :created
    else
      render json: @interest.errors, status: :unprocessable_entity
    end
  end

  private

  def interest_params
    params.require(:interest).permit(:product_id, :score)
  end
end
