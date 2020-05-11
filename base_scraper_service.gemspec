Gem::Specification.new do |s|
  s.name               = "base_scraper_service"
  s.version            = "0.0.1"
  s.authors = ["Qbatch"]
  s.date = %q{2020-05-11}
  s.description = %q{Base scraper service to handle multiple services}
  s.files = Dir["lib/**/*.rb"]
  s.require_paths = ["lib"]
  s.summary = 'manage multiple scraper services'

  s.add_dependency 'sinatra'
  s.add_dependency 'mechanize'
  s.add_dependency 'nokogiri'
  s.add_dependency 'thread'
  s.add_dependency 'fileutils'
  s.add_dependency 'logger'
  s.add_dependency 'date'
  s.add_dependency 'activesupport'
  s.add_dependency "dotenv"
  s.add_dependency 'csv'
  s.add_dependency 'json'
  s.add_dependency 'library_stdnums'
  s.add_dependency 'shotgun'
  s.add_dependency 'puma'
  s.add_dependency 'byebug'
end
