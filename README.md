# RSpec::Candy

[![Gem Version](https://badge.fury.io/rb/rspec-candy.svg)](https://badge.fury.io/rb/rspec-candy)
[![CI](https://github.com/aladac/rspec-candy/actions/workflows/main.yml/badge.svg)](https://github.com/aladac/rspec-candy/actions/workflows/main.yml)

Eye candy for RSpec: beautiful progress bars and coverage reports.

## Features

- **TTY Progress Bar** - Rich progress bar with ETA, rate, and percentage
- **Colored Output** - Green for pass, red for fail, yellow for pending
- **Coverage Table** - Beautiful TTY table showing coverage per file
- **Non-TTY Fallback** - Dots/characters when not in a terminal

## Installation

Add to your Gemfile:

```ruby
group :test do
  gem "rspec-candy"
end
```

Then:

```bash
bundle install
```

## Usage

### Formatter

Use the formatter via command line:

```bash
bundle exec rspec --require rspec/candy --format RSpec::Candy::Formatter
```

Or add to `.rspec`:

```
--require rspec/candy
--format RSpec::Candy::Formatter
```

### Coverage Report

After running tests with SimpleCov, display a coverage table:

```bash
bundle exec rspec-candy-coverage
```

Or programmatically:

```ruby
require "rspec/candy"

reporter = RSpec::Candy::Coverage.new
reporter.report
```

### Rake Task

Add to your Rakefile:

```ruby
desc "Run tests with candy formatter and show coverage"
task :candy do
  system("bundle exec rspec --require rspec/candy --format RSpec::Candy::Formatter")
  system("bundle exec rspec-candy-coverage")
end
```

## Screenshot

```
Running 820 examples...

[████████████████████████████████████████████████████████████████░░░░░░░░░░░] 750/820 91% │ 00:03 │ 125.3/s

✓ 820 examples, 0 failures
Finished in 6.54s

┌──────────────────────┬───────────┬──────────────────────┬────────┐
│ File                 │ Lines     │ Coverage             │ %      │
├──────────────────────┼───────────┼──────────────────────┼────────┤
│ app.rb               │ 45/50     │ ██████████████████░░ │ 90.0%  │
│ builder.rb           │ 38/45     │ █████████████████░░░ │ 84.4%  │
└──────────────────────┴───────────┴──────────────────────┴────────┘

Total: 892/950 (93.9%)
12 files at 100% (not shown)
```

## Configuration

### Coverage Reporter Options

```ruby
RSpec::Candy::Coverage.new(
  coverage_path: "coverage/.resultset.json",  # SimpleCov output path
  lib_filter: "lib/"                          # Filter files by path
)
```

## Requirements

- Ruby >= 3.2.0
- RSpec >= 3.0
- SimpleCov (for coverage reports)

## License

MIT License. See [LICENSE.txt](LICENSE.txt).
