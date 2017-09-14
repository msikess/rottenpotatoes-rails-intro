class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if params[:sorting]
      session[:sorting] = params[:sorting]
      @movies = Movie.all.order(session[:sorting])
    elsif session[:sorting]
      @movies = Movie.all.order(session[:sorting])
    else
      @movies = Movie.all
    end
    @all_ratings = Movie.ratings_array
    if params[:ratings]
      session[:ratings] = params[:ratings]
      @clicked_boxes = session[:ratings].keys
    elsif session[:ratings]
      @clicked_boxes = session[:ratings].keys
    else
      @clicked_boxes = @all_ratings
    end
    puts "CLICKED BOXES"
    puts @clicked_boxes
    @movies = @movies.where(:rating => @clicked_boxes)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
