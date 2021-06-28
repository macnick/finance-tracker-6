class UsersController < ApplicationController
  def my_portfolio
    @my_portfolio = current_user.stocks
  end
end
