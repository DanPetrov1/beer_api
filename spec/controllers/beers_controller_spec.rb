# frozen_string_literal: true

require 'rails_helper'

describe BeersController do
  describe 'GET index' do
    let(:beer_1) { Beer.where(id: 11).first_or_create!(name: 'Name1', description: 'Description1', image_url: 'Image url1') }
    let(:beer_2) { Beer.where(id: 12).first_or_create!(name: 'Name2', description: 'Description2', image_url: 'Image url2') }
    let(:beers) { [beer_1, beer_2] }

    before do
      beers
    end

    it 'renders all beers in json format' do
      get :index

      expect(response.body).to eq(beers.to_json)
    end
  end

  describe 'GET show' do
    let(:id) { 11 }
    let(:beer) { Beer.where(id: 11).first_or_create!(name: 'Name', description: 'Description', image_url: 'Image url') }
    let(:error_message) { 'No beer with such ID' }

    context 'when beer exists' do
      before do
        beer
      end

      it 'finds and renders data' do
        get :show, params: { id: id }

        expect(response.body).to eq(beer.to_json)
      end
    end

    context 'when beer doesn\'t exist' do
      it 'renders error message' do
        get :show, params: { id: id }

        expect(response.body).to eq(error_message)
      end
    end
  end

  describe 'PUT #update' do
    let(:id) { 11 }
    let(:beer) { Beer.where(id: 11).first_or_create!(name: 'Name', description: 'Description', image_url: 'Image url') }
    let(:exist_error_message) { 'No beer with such ID' }
    let(:update_error_message) { 'No beer with such ID' }

    context 'when beer exists' do
      before do
        beer
      end

      context 'when params are valid' do
        let(:name) { 'New name' }
        let(:description) { 'New description' }
        let(:params) do
          {
            id: id,
            beer: {
              name: name,
              description: description
            }
          }
        end

        it 'updates beer and outputs information' do
          put :update, params: params

          expect(response.body).to eq(Beer.find(11).to_json)
        end
      end
    end

    context 'when beer doesn\'t exist' do
      it 'renders error message' do
        put :update, params: { id: id }

        expect(response.body).to eq(exist_error_message)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:id) { 11 }
    let(:beer) { Beer.where(id: 11).first_or_create!(name: 'Name', description: 'Description', image_url: 'Image url') }
    let(:success_message) { 'Beer was deleted successfully' }
    let(:error_message) { 'No beer with such ID' }

    context 'when beer exists' do
      before do
        beer
      end

      it 'deletes and renders success message' do
        delete :destroy, params: { id: id }

        expect(response.body).to eq(success_message)
      end
    end

    context 'when beer doesn\'t exist' do
      it 'renders error message' do
        delete :destroy, params: { id: id }

        expect(response.body).to eq(error_message)
      end
    end
  end
end
