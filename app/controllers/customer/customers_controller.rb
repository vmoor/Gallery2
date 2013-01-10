class Customer::CustomersController < ApplicationController

  # GET /customers/1
  # GET /customers/1.json
  def show
    @customer = Customer.find(params[:id])
    @albums = @customer.albums

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @customer }
    end
  end
end
