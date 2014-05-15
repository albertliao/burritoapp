class BurritosController < ApplicationController

before_action :authenticate_user

  def index
    @burritos = Burrito.all
  end

  def show
    @burrito = Burrito.find(params[:id])
  end

  def new
    @burrito = Burrito.new
    @ingredients = Ingredient.all
  end

  def create
    Burrito.create(params.require(:burrito).permit(:name,:picture, :ingredient_ids => []))
    redirect_to burritos_path
  end

  def edit
    @burrito = Burrito.find(params[:id])
    @ingredients = Ingredient.all
  end

  def update
    @burrito = Burrito.find(params[:id])
    if @burrito.update(params.require(:burrito).permit(:name,:picture, :ingredient_ids => []))
      redirect_to burritos_path
    else
      render 'edit'
    end
  end

  def destroy
  end
end
