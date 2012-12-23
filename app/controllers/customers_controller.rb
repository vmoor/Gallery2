class CustomersController < ApplicationController
  before_filter :check_owner

  # GET /customers
  # GET /customers.json
  def index
    @user = current_user
    @customers = @user.customers

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customers }
    end
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @user = User.find(params[:user_id])
    @customer = @user.customers.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customers/new
  # GET /customers/new.json
  def new
    @user = current_user
    @customer = @user.customers.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customers/1/edit
  def edit
    @customer = Customer.find(params[:id])
  end

  # POST /customers
  # POST /customers.json
  def create
    @user = current_user
    @customer = @user.customers.build(params[:customer])
    generated_password = Devise.friendly_token.first(6)

    @customer.password = generated_password
    @customer.password_visible = generated_password

    respond_to do |format|
      if @customer.save
        format.html { redirect_to user_customer_path(@user, @customer), notice: 'Customer was successfully created.' }
        format.json { render json: @customer, status: :created, location: @customer }
      else
        format.html { render action: "new" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /customers/1
  # PUT /customers/1.json
  def update
    @customer = Customer.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to customers_url }
      format.json { head :no_content }
    end
  end

  def check_owner
    if current_user
      if current_user.id != params[:user_id].to_i
        redirect_to current_user
      end
    elsif current_customer
      unless ((current_customer.id == params[:id].to_i) && (current_customer.user.id == params[:user_id].to_i))
        redirect_to user_customer_path(current_customer.user_id, current_customer)
      end
    else
      redirect_to root_path
    end
  end
end
