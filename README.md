# RSpec::Candy
<img width="974" height="529" alt="image" src="https://github.com/user-attachments/assets/5c8e79f2-658c-4aac-a735-7c5f8a5bf14e" />

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
Running 42 examples...

[██████████████████████████████████████░░░░░░░░░░] 38/42 90% │ 00:01

✓ 42 examples, 0 failures
Finished in 0.73s

┌─────────────┬────────┬────────────────┬───────┐
│ File        │ Lines  │ Coverage       │ %     │
├─────────────┼────────┼────────────────┼───────┤
│ cli.rb      │ 85/100 │ █████████████░ │ 85.0% │
│ builder.rb  │ 38/50  │ ███████████░░░ │ 76.0% │
│ remote.rb   │ 22/40  │ ████████░░░░░░ │ 55.0% │
└─────────────┴────────┴────────────────┴───────┘

Total: 145/190 (76.3%)
4 files at 100% (not shown)
```

## Requirements

- Ruby >= 3.2.0
- RSpec >= 3.0
- SimpleCov (for coverage reports)

## License

MIT License. See [LICENSE.txt](LICENSE.txt).
