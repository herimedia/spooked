Gem::Specification.new do |s|
  s.authors           = ["Niels Ganser"]
  s.email             = "niels@herimedia.com"
  s.extra_rdoc_files  = %w(
    CHANGELOG.md
    README.md
  )
  s.files             = Dir["lib/**/*.rb"]
  s.homepage          = "https://github.com/herimedia/spooked"
  s.licenses          = ["Apache-2.0"]
  s.name              = "spooked"
  s.summary           = "An experimental unofficial API client for the ghost.org blogging platform"
  s.version           = "0.0.1"

  s.add_runtime_dependency "faraday",             "~> 0.9"
  s.add_runtime_dependency "faraday_middleware",  "~> 0.10"
end
