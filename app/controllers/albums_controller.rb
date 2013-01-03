class AlbumsController < ApplicationController
  before_filter :check_owner
  # GET /albums
  # GET /albums.json
  def index
    @user = current_user
    @customer = @user.customers.find(params[:customer_id])
    @albums = @customer.albums

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @albums }
    end
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    @user = current_user
    @customer = @user.customers.find(params[:customer_id])
    @album = @customer.albums.find(params[:id])
    @photos = @album.photos
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photos.map{|photo| photo.to_jq_image }  }
    end
  end

  # GET /albums/new
  # GET /albums/new.json
  def new
    @user = current_user
    @customer = @user.customers.find(params[:customer_id])
    @album = @customer.albums.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @album }
    end
  end

  # GET /albums/1/edit
  def edit
    @user = current_user
    @customer = @user.customers.find(params[:customer_id])
    @album = @customer.albums.find(params[:id])
  end

  # POST /albums
  # POST /albums.json
  def create
    @user = current_user
    @customer = @user.customers.find(params[:customer_id])
    @album = @customer.albums.build(params[:album])

    respond_to do |format|
      if @album.save
        format.html { redirect_to user_customer_path(@user, @customer), notice: 'Album was successfully created.' }
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.json
  def update
    @user = current_user
    @customer = @user.customers.find(params[:customer_id])
    @album = @customer.albums.find(params[:id])

    respond_to do |format|
      if @album.update_attributes(params[:album])
        format.html { redirect_to user_customer_albums_path(@user, @customer), notice: 'Album was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @user = current_user
    @customer = @user.customers.find(params[:customer_id])
    @album = @customer.albums.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to user_customer_path(@user, @customer) }
      format.json { head :no_content }
    end
  end

  def check_owner
    if customer_signed_in?
      redirect_to user_customer_path(current_customer.user, current_customer)
    elsif user_signed_in?
      unless current_user.id == params[:user_id].to_i
        redirect_to user_path(current_user)
      end
    else
      redirect_to new_user_session_path
    end
      
  end
end
