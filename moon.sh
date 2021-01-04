#!/usr/bin/env ruby

require 'net/http'

uri = URI('https://wttr.in/London?format=%m')

Net::HTTP.start(uri.host, uri.port) do |http|
  request = Net::HTTP::Get.new uri

  response = http.request request

  if response.code == 200
    File.open("#{ENV['HOME']}/.moon") do |f|
        f.write(response.body)
    end
  end
end
