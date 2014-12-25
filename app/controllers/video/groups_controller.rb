class Video::GroupsController < ApplicationController
  before_action :set_video_group, only: [:show, :edit, :update, :destroy]

  # GET /video/groups
  # GET /video/groups.json
  def index
    @video_groups = Video::Group.all
    respond_with @video_groups
  end

  # GET /video/groups/1
  # GET /video/groups/1.json
  def show
    respond_with @video_group
  end

  # GET /video/groups/new
  def new
    @video_group = Video::Group.new
    respond_with @video_group
  end

  # GET /video/groups/1/edit
  def edit
  end

  # POST /video/groups
  # POST /video/groups.json
  def create
    @video_group = Video::Group.new(video_group_params)

    respond_to do |format|
      if @video_group.save
        format.html { redirect_to @video_group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @video_group }
      else
        format.html { render :new }
        format.json { render json: @video_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /video/groups/1
  # PATCH/PUT /video/groups/1.json
  def update
    respond_to do |format|
      if @video_group.update(video_group_params)
        format.html { redirect_to @video_group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @video_group }
      else
        format.html { render :edit }
        format.json { render json: @video_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /video/groups/1
  # DELETE /video/groups/1.json
  def destroy
    @video_group.destroy
    respond_to do |format|
      format.html { redirect_to video_groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video_group
      @video_group = Video::Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_group_params
      params.require(:video_group).permit(:value, :tags, :language, :order)
    end
end
