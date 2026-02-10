# frozen_string_literal: true

require_relative "lib/rspec/candy/version"

Gem::Specification.new do |spec|
  spec.name = "rspec-candy"
  spec.version = RSpec::Candy::VERSION
  spec.authors = ["Adam Ladachowski"]
  spec.email = ["adam.ladachowski@gmail.com"]

  spec.summary = "Eye candy for RSpec: pretty progress bars and coverage reports"
  spec.description = "A beautiful RSpec formatter with TTY progress bars, colored output, and a stunning coverage report table."
  spec.homepage = "https://github.com/aladac/rspec-candy"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/aladac/rspec-candy"
  spec.metadata["changelog_uri"] = "https://github.com/aladac/rspec-candy/blob/main/CHANGELOG.md"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/ .github/ .standard.yml])
    end
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "rspec-core", ">= 3.0"
  spec.add_dependency "pastel", "~> 0.8"
  spec.add_dependency "tty-progressbar", "~> 0.18"
  spec.add_dependency "tty-table", "~> 0.12"
  spec.add_dependency "tty-screen", "~> 0.8"
end
