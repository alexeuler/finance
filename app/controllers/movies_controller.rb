class MoviesController < ApplicationController
  before_action :set_movie, only: [:destroy, :show, :update]


  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
    @movies = @movies.where("tags LIKE ?", "%"+params[:tag]+"%") if params[:tag]
    render json: @movies
  end


  def show
    render json: @movie
  end

  # POST /movies
  # POST /movies.json

  def create
    @movie = Movie.new(movie_params)
    @movie.save ? render(text:'Ok') : render(text: 'Error')
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    @movie.update(movie_params) ? render(text:'Ok') : render(text: 'Error')
  end


  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.file.clear
    @movie.destroy
    render text:'Ok'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_movie
    @movie = Movie.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def movie_params
    params.require(:movie).permit(:file, :tags, :uid)
  end
end
