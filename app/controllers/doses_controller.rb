class DosesController < ApplicationController
  def new
    @dose = Dose.new
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def create
    @dose = Dose.new(dose_params)
    @dose.ingredient = Ingredient.find(params[:dose][:ingredient_id])
    @dose.cocktail = Cocktail.find(params[:cocktail_id])

    if @dose.save
      redirect_to cocktail_path(@dose.cocktail)
    else
      render :new
    end
  end

  def destroy
    @cocktail = Dose.find(params[:id]).cocktail
    Dose.delete(params[:id])
    redirect_to cocktail_path(@cocktail)
  end

  private

  def dose_params
    params.require(:dose).permit(:description)
  end
end
