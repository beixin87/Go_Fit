class CalculatorController < ApplicationController
  def show
    @user = User.find(params[:id])
    @calculator = @user.calculator
    @height = @user.height
    @weight = @user.weight
  end
end
