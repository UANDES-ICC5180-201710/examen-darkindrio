class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    search_param = params[:search]
    if search_param.nil?
      @games = Game.all
    else
      @games = Game.where("title like ?","%#{params[:search]}%").uniq.sort_by{'title ASC'}
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
    if current_user.is_staff == false
      redirect_to games_path
    end
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    if current_user.is_staff == false
      redirect_to games_path
    end
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def buy_game
    game_id = params[:game_id]
    buy = Buy.where(:user_id=>current_user.id).where(:game_id=>game_id)
    status = "fail"
    if buy.empty?
      gamee = Game.find(game_id)
      buyy = Buy.create
      buyy.user = current_user
      buyy.game = gamee
      if buyy.save
        status = "create"
      end
    else
      for x in buy
        x.destroy
      end
      status = "destroy"
    end
    
    jsonObject = {"text" => status}
    respond_to do |format|
      format.html
      format.json { render json: jsonObject }
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:title, :description, :image_url)
    end
end
