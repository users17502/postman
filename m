class MoviesController < ApplicationController

  # GET /movies
  def index
    movies = Movie.all
    render json: movies
  end

  # GET /movies/:id
  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      render json: movie
    else
      render json: { error: "Movie not found" }
    end
  end

  # POST /movies
  def create
    movie = Movie.new(movie_params)

    if movie.save
      render json: movie
    else
      render json: { error: movie.errors.full_messages }
    end
  end

  # PUT/PATCH /movies/:id
  def update
    movie = Movie.find_by(id: params[:id])

    if movie
      movie.update(movie_params)
      render json: movie
    else
      render json: { error: "Movie not found" }
    end
  end

  # DELETE /movies/:id
  def destroy
    movie = Movie.find_by(id: params[:id])

    if movie
      movie.destroy
      render json: { message: "Movie deleted" }
    else
      render json: { error: "Movie not found" }
    end
  end

  private

  def movie_params
    params.permit(:title, :director, :releaseyear, :genre)
  end

end
