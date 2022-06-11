$:.push File.expand_path( "../lib", __FILE__ )

require "passenger_top/version"

Gem::Specification.new do |spec|

  spec.name    = "passenger_top"
  spec.summary = "PassengerTop"

  spec.version = PassengerTop::VERSION

  spec.authors = [ "Luis Corrêa d'Almeida" ]
  spec.email   = [ "luis@fullfabric.com" ]

  spec.files = Dir[ "{lib}/**/*" ]

  spec.add_dependency "bundler"
  spec.add_dependency "rake"
  spec.add_dependency "json"
  spec.add_dependency "table_print"
  spec.add_dependency "awesome_print"
  spec.add_dependency "passenger"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"

  spec.add_development_dependency "byebug"

end
