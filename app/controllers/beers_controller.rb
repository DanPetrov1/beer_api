# frozen_string_literal: true

class BeersController < ApplicationController
  before_action :find_beer, only: %i[show update destroy]

  def index
    render json: Beer.all
  end

  def show
    if @beer
      render json: @beer
    else
      render json: 'No beer with such ID'
    end
  end

  def update
    render json: 'No beer with such ID' and return unless @beer

    if !Beer.find_by(id: beer_params.fetch(:id, nil)) && @beer.update(beer_params)
      render json: Beer.find(params[:id])
    else
      render json: 'Error when updating'
    end
  end

  def destroy
    if @beer
      @beer.destroy!
      render json: 'Beer was deleted successfully'
    else
      render json: 'No beer with such ID'
    end
  end

  private

  def find_beer
    @beer = Beer.find_by(id: params[:id])
  end

  def beer_params
    params.require(:beer).permit(:id, :name, :description, :image_url)
  end
end
