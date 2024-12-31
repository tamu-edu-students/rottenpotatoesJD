class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]

  # GET /movies or /movies.json
  def index
    @movies = if params[:sort] == "title"
                Movie.order(:title)  # Ascending alphabetical order
              elsif params[:sort] == "reverse_title"
                Movie.order(title: :desc)  # Descending alphabetical order
              elsif params[:sort] == "date"
                Movie.order(:release_date)  # Normal order by release date
              elsif params[:sort] == "reverse_date"
                Movie.order(release_date: :desc)  # Reverse order by release date
              elsif params[:sort] == "rating"
                Movie.order(:rating)  # Sort by rating in ascending order
              elsif params[:sort] == "reverse_rating"
                Movie.order(rating: :desc)  # Sort by rating in descending order
              else
                Movie.all  # No sorting
              end
  end
  
  
  
  

  # GET /movies/1 or /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end
  

  # GET /movies/1/edit
  def edit
  end

  # POST /movies or /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to movie_path(@movie, request.query_parameters), notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to movie_path(@movie, request.query_parameters), notice: "Movie was successfully updated." }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    @movie.destroy!

    respond_to do |format|
      format.html { redirect_to movies_path(request.query_parameters), status: :see_other, notice: "Movie was successfully destroyed." }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.expect(movie: [ :title, :rating, :description, :release_date ])
    end
end
