# RSpec::Candy

[![Gem Version](https://badge.fury.io/rb/rspec-candy.svg)](https://badge.fury.io/rb/rspec-candy)
[![CI](https://github.com/aladac/rspec-candy/actions/workflows/main.yml/badge.svg)](https://github.com/aladac/rspec-candy/actions/workflows/main.yml)

Eye candy for RSpec: beautiful progress bars and coverage reports.

## Features

- **TTY Progress Bar** - Rich progress bar with ETA, rate, and percentage
- **Colored Output** - Green for pass, red for fail, yellow for pending
- **Coverage Table** - Automatically displays if SimpleCov data exists
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

Add to `.rspec`:

```
--require rspec/candy
--format RSpec::Candy::Formatter
```

Then just run:

```bash
bundle exec rspec
```

You get a progress bar, test results, and coverage table (if SimpleCov is configured) - all in one.

## Screenshot

```
Running 870 examples...

[████████████████████████████████████████████████████████████████░░░░░░░░░░░] 750/870 86% │ 00:02 │ 125.3/s

✓ 870 examples, 0 failures
Finished in 0.73s

┌──────────────────────┬───────────┬──────────────────────┬────────┐
│ File                 │ Lines     │ Coverage             │ %      │
├──────────────────────┼───────────┼──────────────────────┼────────┤
│ cli.rb               │ 185/208   │ ██████████████████░░ │ 88.9%  │
│ builder.rb           │ 78/89     │ ██████████████████░░ │ 87.6%  │
└──────────────────────┴───────────┴──────────────────────┴────────┘

Total: 2520/3356 (75.1%)
16 files at 100% (not shown)
```

## Requirements

- Ruby >= 3.2.0
- RSpec >= 3.0
- SimpleCov (for coverage reports)

## License

MIT License. See [LICENSE.txt](LICENSE.txt).
