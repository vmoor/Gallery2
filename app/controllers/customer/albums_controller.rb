class Customer::AlbumsController < ApplicationController

  # GET /albums/1
  # GET /albums/1.json
  def show
    @customer = Customer.find(params[:customer_id])
    @album = @customer.albums.find(params[:id])
    @photos = @album.photos
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photos.map{|photo| photo.to_jq_image }  }
    end
  end
end
