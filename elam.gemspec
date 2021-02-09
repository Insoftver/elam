require_relative 'lib/elam/version'

Gem::Specification.new do |spec|
  spec.name          = "elam"
  spec.version       = Elam::VERSION
  spec.authors       = ["insoftver"]
  spec.email         = ["d.insoftver@gmail.com"]

  spec.summary       = %q{English Language Automated Method.}
  spec.description   = %q{Learn English by practicing thousands of exercises.}
  spec.homepage      = "https://github.com/Insoftver/elam"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://github.com/Insoftver/elam"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Insoftver/elam"
  spec.metadata["changelog_uri"] = "https://github.com/Insoftver/elam"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
