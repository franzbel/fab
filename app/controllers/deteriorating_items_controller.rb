class DeterioratingItemsController < ApplicationController
  def index
    @items = DeterioratingItem.all
  end

  def new
    @deteriorating_item = DeterioratingItem.new
    4.times do
      quantity = @deteriorating_item.quantities.build
      1.times {quantity.build_expiration_date}
    end
  end

  def create
    render(:text => params)
  end
end
