class NotesController < ApplicationController
  # GET /notes
  # GET /notes.json
  def index
    @user = current_user
    @customer = @user.customers.find(params[:customer_id])
    @notes = @customer.notes

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notes }
    end
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    @note = Note.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @note }
    end
  end

  # GET /notes/new
  # GET /notes/new.json
  def new
    @user = current_user
    @customer = @user.customers.find(params[:customer_id])
    @note = @customer.notes.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @note }
    end
  end

  # GET /notes/1/edit
  def edit
    @note = Note.find(params[:id])
  end

  # POST /notes
  # POST /notes.json
  def create
    @user = current_user
    @customer = @user.customers.find(params[:customer_id])
    @note = @customer.notes.build(params[:note])

    respond_to do |format|
      if @note.save
        format.html { redirect_to user_customer_notes_path(@user, @customer) , notice: 'Note was successfully created.' }
        format.json do
          render json: {
            note: @note,
            status: :created,
            note_item: render_to_string(partial: 'note_item', locals: {note: @note}, formats: [:html])
          }.to_json
        end
      else
        format.html { render action: "new" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notes/1
  # PUT /notes/1.json
  def update
    @note = Note.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json do
        render json: {
          note: @note,
          status: :deleted
        }.to_json
      end
    end
  end
end
