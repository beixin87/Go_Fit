class CalculatorController < ApplicationController

  def show
    @user = current_user
    @age = age(@user.date_of_birth)
  end

private
  def age(date_of_birth)
    today = Date.today
    age = today.year - date_of_birth.year
    age -= 1 if date_of_birth.strftime("%m%d").to_i > today.strftime("%m%d").to_i
    age
  end

<<<<<<< HEAD
=======

>>>>>>> e7629e842362b2a3c50fe57c5ff68ca01c3f3242
end
