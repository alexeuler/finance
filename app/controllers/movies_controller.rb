class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    @movies = Movie.all
    respond_with(@movies)
  end

  def show
    respond_with(@movie)
  end

  def new
    @movie = Movie.new
    respond_with(@movie)
  end

  def edit
  end

  def create
    @movie = Movie.new(movie_params)
    flash[:notice] = 'Movie was successfully created.' if @movie.save
    respond_with(@movie)
  end

  def update
    flash[:notice] = 'Movie was successfully updated.' if @movie.update(movie_params)
    respond_with(@movie)
  end

  def destroy
    @movie.destroy
    respond_with(@movie)
  end

  private
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:tags)
    end
end
