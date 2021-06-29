class UserStocksController < ApplicationController
  def create
    stock = Stock.check_db(params[:ticker])
    if stock.blank? 
      stock = Stock.new_lookup(params[:ticker])
      new_stock = Stock.new(ticker: stock.symbol, name: stock.company_name, last_price: stock.latest_price)
      new_stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: new_stock)
    flash[:notice] = "Stock #{new_stock.name} was successfully added to your portfolio"
    redirect_to my_portfolio_path
  end

  def destroy
    stock = Stock.find(params[:id])
    user_stock = UserStock.where(stock_id: stock.id, user_id: current_user.id).first
    user_stock.destroy
    flash[:notice] = "#{stock.ticker} was successfully removed from portfolio"
    redirect_to my_portfolio_path
  end
end
