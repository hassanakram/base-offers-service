require 'sinatra'
require 'dotenv'
# require "./#{ENV['SERVICE_NAME']}_offers_service"
# require "./secondsale_offers_service"

configure { set :server, :puma }

module BaseScraper
  class Base < Sinatra::Base
    get "/las/" do
      puts "sample djfhsjfh ksj hdfnksjdhfs jsdhf ----------------------"
    end
  end
end


# class Base < Sinatra::Base

#   get "/secondsale/isbn_offers".to_s do
#     isbn = params[:isbn]
#     uuid = SecureRandom.uuid

#     @res = {
#       isbn: isbn,
#       uuid: uuid,
#       item_condition: params[:item_condition],
#       ship_type: params[:ship_type]
#     }

#     if valid_params?
#       service_response = SecondsaleOffersService.new(isbn, uuid).scrape_offers
#       offers = service_response[:offers]

#       offers = filter_offers(offers)
#       offers.sort_by! { |offer| offer[:total_price] }
#       offers_count = offers.count

#       @res[:status] = service_response[:status]
#       @res[:short_message] = service_response[:short_message]
#       @res[:long_message] = service_response[:long_message]
#       if @res[:status] == 200
#         @res[:offers_count] = offers.count
#         @res[:data] = { offers: offers }
#       end
#     else
#       @res[:status] = 400
#       @res[:short_message] = 'error'
#     end

#     halt @res[:status], @res.to_json
#   end

#   not_found do
#     send_file( 'public/404.html', { status: 404 })
#   end

#   def get_service_name
#     ENV['SERVICE_NAME'].capitalize + 'OffersService'
#   end

#   def send_sinatra_file(path)
#     file_path = File.join(File.dirname(__FILE__), 'public',  path)
#     file_path = File.join(file_path, 'index.html') unless file_path =~ /\.[a-z]+$/i and !File.directory?(file_path)
#     File.exist?(file_path) ? send_file(file_path) : not_found
#   end

#   def filter_offers(offers)
#     offers = offers.select{ |offer| offer[:Item_Condition].downcase ==  params[:item_condition].downcase} if params[:item_condition].present?
#     offers = offers.select{ |offer| offer[:ship_type].downcase ==  params[:ship_type].downcase} if params[:ship_type].present?

#     offers
#   end

#   def constantize(lower_case_string)
#     "#{lower_case_string.split('_').collect(&:capitalize).join + 'OffersService'}".constantize
#   end

#   def valid_params?
#     valid_isbn?(params[:isbn]) &&
#     valid_book_condition?(params[:item_condition].to_s) &&
#     valid_ship_type?(params[:ship_type].to_s)
#   end

#   def valid_isbn?(isbn)
#     return true if StdNum::ISBN.valid?(isbn) && [10, 13].include?(isbn.size)

#     @res[:long_message] = 'invalid isbn'
#     false
#   end

#   def valid_book_condition?(item_condition)
#     return true if ['', 'used', 'new'].include?(item_condition.downcase)

#     @res[:long_message] = 'invalid item condition'
#     false
#   end

#   def valid_ship_type?(ship_type)
#     return true if ['', 'standard', 'expedited'].include?(ship_type.downcase)

#     @res[:long_message] = 'invalid ship type'
#     false
#   end
# end
