class UserStocksController < ApplicationController
  def create
    stock = Stock.check_db(params[:ticker])
    if stock.blank? 
      new_stock = Stock.new_lookup(params[:ticker])
      stock = Stock.new(ticker: new_stock.symbol, name: new_stock.company_name, last_price: new_stock.latest_price)
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.name} was successfully added to your portfolio"
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
