class AssociationTypesController < ApplicationController
  before_action :set_association_type, only: [:show, :edit, :update, :destroy]

  # GET /association_types
  # GET /association_types.json
  def index
    @association_types = AssociationType.all
  end

  # GET /association_types/1
  # GET /association_types/1.json
  def show
  end

  # GET /association_types/new
  def new
    @association_type = AssociationType.new
  end

  # GET /association_types/1/edit
  def edit
  end

  # POST /association_types
  # POST /association_types.json
  def create
    @association_type = AssociationType.new(association_type_params)

    respond_to do |format|
      if @association_type.save
        format.html { redirect_to @association_type, notice: 'Association type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @association_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @association_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /association_types/1
  # PATCH/PUT /association_types/1.json
  def update
    respond_to do |format|
      if @association_type.update(association_type_params)
        format.html { redirect_to @association_type, notice: 'Association type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @association_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /association_types/1
  # DELETE /association_types/1.json
  def destroy
    @association_type.destroy
    respond_to do |format|
      format.html { redirect_to association_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_association_type
      @association_type = AssociationType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def association_type_params
      params.require(:association_type).permit(:name)
    end
end
