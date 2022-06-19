# frozen_string_literal: true

class BeersController < ApplicationController
  def index
    render json: Beer.all
  end

  def show
    @beer = Beer.find(params[:id])

    render json: @beer
  end

  def update
    @beer = Beer.find(params[:id])

    if !Beer.find_by(id: beer_params.fetch(:id)) && @beer.update(beer_params)
      puts @beer

      redirect_to beer_path(@beer)
    else
      render json: 'Error when updating'
    end
  end

  def destroy
    @beer = Beer.find(params[:id])
    @beer.destroy!

    render json: 'Beer was deleted successfully'
  end

  private

  def beer_params
    params.require(:beer).permit(:id, :name, :description, :image_url)
  end
end
