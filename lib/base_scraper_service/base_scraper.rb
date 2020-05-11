require 'mechanize'
require 'nokogiri'
require 'thread'
require 'fileutils'
require 'logger'
require "dotenv"
require 'csv'
require 'date'
require 'active_support/time'
require 'library_stdnums'
require 'base_scraper_service'
require_relative 'user_agent'
require_relative 'agent_object'

module BaseScraper
  class Service
    def send_request(agent, uri, params = nil, headers = {}, _optoins = {})
      tries = 0
      max_tries = 5
      page = nil

      refresh_agent(agent)
      change_proxy(agent)
      begin
        page = params.nil? ? agent.get(uri, [], nil, headers) : agent.post(uri, params, headers)

      rescue Mechanize::ResponseCodeError => e
        change_proxy(agent)

        tries += 1

        agent.set_proxy(ENV["LPM_SERVER_URL"], ENV["LPM_SERVER_PORT"]) if tries >= 4

        retry if tries < max_tries
      rescue Exception => e
        refresh_agent(agent)
        change_proxy(agent)

        tries += 1

        agent.set_proxy(ENV["LPM_SERVER_URL"], ENV["LPM_SERVER_PORT"]) if tries >= 4

        retry if tries < max_tries
        puts "Message: #{e.message} from #{uri}, proxy: #{agent.proxy_addr}" if logs_enable?
      end

      page
    end

    def format_price(price)
      return unless price.present?
      price.to_s.strip.gsub("$", "").strip.to_f
    end

    def format_isbn(isbn)
      StdNum::ISBN.convert_to_13(isbn)
    end

    def with_exception(long_message: "", status: 500, short_message: "exception")
      return { offers: [], short_message: short_message, long_message: long_message, status: status }
    end

    def logs_enable?
      ENV["ENABLE_LOGS"] == "true"
    end

    private

    def refresh_agent(agent)
      agent.cookie_jar.clear!
      agent.history.clear
      agent.user_agent = UserAgent.random
    end

    def get_proxy_index
      (0..(@proxy_array.count - 1)).to_a.sample
    end

    def change_proxy(agent)
      if @proxy_array.count > 0
        cur_proxy_index = get_proxy_index
        if @proxy_array[cur_proxy_index].present?
          agent.set_proxy(@proxy_array[cur_proxy_index][0], @proxy_array[cur_proxy_index][1])
        end
      else
        agent.set_proxy(ENV['LPM_SERVER_URL'], ENV['LPM_SERVER_PORT'])
      end
    end
  end
end
