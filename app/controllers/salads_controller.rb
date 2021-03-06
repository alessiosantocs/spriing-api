class SaladsController < ApplicationController
  before_action :set_salad, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:index, :create]

  # GET /salads
  # GET /salads.json
  def index
    @salads = Salad.all
    @salads = @user.salads if @user
  end

  # GET /salads/1
  # GET /salads/1.json
  def show
    raise
  end

  # GET /salads/new
  def new
    previous_ingredients = params[:chosen_ingredients] || []
    previous_ingredients += params[:previous_ingredients] || []

    previous_ingredients = previous_ingredients.map{|ingredient|
      ingredient_id = ingredient.split(":").first
      ingredient_type = ingredient.split(":").second

      "#{Ingredient.find(ingredient_id).name}:#{AssociationType.find(ingredient_type).name}"
    }.join(",")
    @salad = Salad.new(:ingredient_names => previous_ingredients)
  end

  # GET /salads/1/edit
  def edit
  end

  # POST /salads
  # POST /salads.json
  def create
    @salad = Salad.new(salad_params)

    @salad.user = @user if @user

    respond_to do |format|
      if @salad.save
        format.html { redirect_to @salad, notice: 'Salad was successfully created.' }
        format.json { render action: 'show', status: :created, location: @salad }
      else
        format.html { render action: 'new' }
        format.json { render json: @salad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /salads/1
  # PATCH/PUT /salads/1.json
  def update
    respond_to do |format|
      if @salad.update(salad_params)
        format.html { redirect_to @salad, notice: 'Salad was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @salad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /salads/1
  # DELETE /salads/1.json
  def destroy
    @salad.destroy
    respond_to do |format|
      format.html { redirect_to salads_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_salad
      @salad = Salad.find(params[:id])
    end

    def set_user
      @user = User.find_or_create_by_device_uuid(params[:user_id]) || User.find_or_create_by_id(params[:user_id]) if params[:user_id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def salad_params
      params.require(:salad).permit(:name, :ingredient_names)
    end
end
