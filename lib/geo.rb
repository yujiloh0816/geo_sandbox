require 'base64'
require 'json'
require 'net/https'

module Geo
  class << self
    def geocode(address)
      api_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{address}&key=#{ENV['GOOGLE_CLOUD_API_KEY']}"

      encode_url = URI.encode(api_url)
      uri = URI.parse(encode_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request)

      # APIレスポンス出力
      body = JSON.parse(response.body)
      if body['status'] == 'OK'
        body['results'][0]['geometry']['location'].values
      else
        raise "Google Map API failed. Status: #{body['status']} / ErrMessage: #{body['error_message']}" if Rails.env == 'development'
        nil
      end
    end
  end
end
