class UsersController < ApplicationController
  before_filter :is_user_owner


  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
 #     format.json { render json: @photos.map{|photo| photo.to_jq_image }  }
    end
  end

# GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def dashboard 
    @customers = current_user.customers
  end

  def is_user_owner
    if current_user
      if current_user.id != params[:id].to_i
        redirect_to dashboard_user_path(current_user)
      end
    else
      redirect_to root_path
    end
  end
end
