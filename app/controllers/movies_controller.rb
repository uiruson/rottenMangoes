class MoviesController < ApplicationController

  def index
    
    if params[:keyword] && params[:runtime_in_minutes] == "0"
      @movies = Movie.search_movie_by_keyword(params[:keyword])
    elsif params[:runtime_in_minutes] && params[:keyword].empty?
      @movies = Movie.search_movie_by_runtime(params[:runtime_in_minutes])
    elsif params[:keyword] && params[:runtime_in_minutes]
      @movies = Movie.search_movie_by_all_categories(params[:keyword],params[:runtime_in_minutes])
    else
      @movies = Movie.all
    end

    @user = current_user
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description
    )
  end
end
