# frozen_string_literal: true

require 'uri'
require 'net/http'

namespace :beer do
  desc 'Get 10 random beers'
  task random: :environment do
    index = 0

    while index < 10
      uri = URI('https://api.punkapi.com/v2/beers/random')
      response = Net::HTTP.get_response(uri)

      next unless response.code == '200'

      result = JSON.parse(response.body)
      beer_params = result[0].select { |key, _value| %w[id name description image_url].include?(key) }
      beer = Beer.new(beer_params)

      next unless beer.save

      index += 1
    end
  end
end
