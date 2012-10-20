class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #Getting the ratings for the form
    @all_ratings=Movie.get_ratings
    @r=Hash.new
    #Reset all check marks values to false, rely on params[:ratings]
    if (params[:ratings]==nil)
      @all_ratings.each do |i|
        @r[i]=true
        end
    else
      @all_ratings.each do |f|
        @r[f]=false
        end
    end
    #Sorting of original display list with all ratings check marked 
    @sort_var=params[:sort]

    #Handling check marked boxes ONLY
    unless(params[:ratings]==nil)#&&params[:commit]==nil)
         @movies_presort=Movie.find_all_by_rating(params[:ratings].keys)
     if (params[:sort]=='title')
         @movies=@movies_presort.sort_by { |t| t.title}
     elsif (params[:sort]=='release_date')
       @movies=@movies_presort.sort_by { |t| t.release_date}
     else 
       @movies=@movies_presort
     end
    #write keys out for final display
      params[:ratings].keys.each do |t|
        @r[t]=true
    end
    else
    @movies = Movie.order(params[:sort])
    end
  end
  
  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
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
