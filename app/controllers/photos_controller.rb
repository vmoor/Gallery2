class PhotosController < ApplicationController
  # GET /photos
  # GET /photos.json
  def index
    @album = Album.find(params[:album_id])
    @photos = @album.photos
 #   @photo = @album.photos.build
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos.map{|photo| photo.to_jq_image } }
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @album = Album.find(params[:album_id])
    @photo = @album.photos.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { }
    end
  end

  # GET /photos/new
  # GET /photos/new.json
  def new
    @album = Album.find(params[:album_id])
    @photo = @album.photos.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @album = Album.find(params[:album_id])
    @photo = @album.photos.find(params[:id])
  end

  # POST /photos
  # POST /photos.json
  def create
    @album = Album.find(params[:album_id])
    @photo = @album.photos.build(params[:photo])

    respond_to do |format|
      if @photo.save
        format.html {
          render :json => [@photo.to_jq_image].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json {
          render :json => [@photo.to_jq_image].to_json
        }
      else
        render :json => [{:error => "custom_failure"}], :status => 304
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.json
  def update
    @album = Album.find(params[:album_id])
    @photo = @album.photos.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to album_photos_url(@album), notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @album = Album.find(params[:album_id])
    @photo = @album.photos.find(params[:id])
    @photo.destroy

    render :json => true
  end
end
