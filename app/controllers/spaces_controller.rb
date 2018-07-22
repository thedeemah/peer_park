class SpacesController < ApplicationController
  before_action :set_space, only: [:show, :edit, :update, :destroy]

  # GET /spaces
  # GET /spaces.json
  def index
    @spaces = Space.all
  end

  # GET /spaces/1
  # GET /spaces/1.json
  def show
  end

  # GET /spaces/new
  def new
    @space = Space.new
  end

  # GET /spaces/1/edit
  def edit
    @space.hourly_rate = @space.hourly_rate.to_f / 100
  end

  # POST /spaces
  # POST /spaces.json
  def create
    @space = Space.new(space_params.merge(user: current_user))
    if not @space.has_valid_state
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @space, status: :unprocessable_entity }
      end
    else
      respond_to do |format|
        if @space.save
          format.html { redirect_to edit_space_path(@space), notice: 'Space was successfully created.' }
          format.json { render :show, status: :created, location: @space }
        else
          format.html { render :new }
          format.json { render json: @space.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /spaces/1
  # PATCH/PUT /spaces/1.json
  def update
    valid_space_params = space_params
    valid_space_params[:hourly_rate] = (space_params[:hourly_rate].to_f * 100).to_i.to_s
    respond_to do |format|
      if @space.update(valid_space_params)
        format.html { redirect_to @space, notice: 'Space was successfully updated.' }
        format.json { render :show, status: :ok, location: @space }
      else
        format.html { render :edit }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spaces/1
  # DELETE /spaces/1.json
  def destroy
    @space.destroy
    respond_to do |format|
      format.html { redirect_to spaces_url, notice: 'Space was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_space
      @space = Space.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def space_params
      params.require(:space).permit(:user_id, :address, :city, :state, :zip, :size, :avail_m, :avail_t, :avail_w, :avail_th, :avail_f, :avail_sa, :avail_su, :hourly_rate, :description)
    end

end
