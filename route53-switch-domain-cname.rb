#!/usr/bin/env ruby

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'public_suffix', require: true
end

domains_file = ARGV[0]
cname = ARGV[1].gsub(/\.$/, "")

domains = File.read(domains_file)
              .split("\n")
              .map { |x| PublicSuffix.parse(x) }

domains.each do |domain|
  puts <<-EOH
cli53 rrcreate --replace #{domain.domain} '#{domain.trd} 60 CNAME #{cname}.'
  EOH
end
