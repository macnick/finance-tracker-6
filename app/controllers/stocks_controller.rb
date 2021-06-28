class StocksController < ApplicationController
  
  def search
    if params[:stock].present? 
      @stock = Stock.new_lookup(params[:stock])
      if @stock 
        # respond_to do |f|
          # f.js { render partial: 'users/result'}
        # end
        # render partial: 'users/result'
        redirect_to my_portfolio_path
      else
        flash.now[:alert] = "Please enter a valid symbol"
        render partial: 'users/result'
      end
    else 
      flash[:alert] = "Please enter a symbol to search"
      redirect_to my_portfolio_path
    end
    # byebug
  end

end