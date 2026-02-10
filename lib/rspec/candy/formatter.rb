# frozen_string_literal: true

require "rspec/core"
require "tty-progressbar"
require "pastel"

module RSpec
  module Candy
    class Formatter
      ::RSpec::Core::Formatters.register self,
        :start, :example_passed, :example_failed, :example_pending, :stop, :dump_summary

      def initialize(output)
        @output = output
        @failed = []
        @pending = []
        @pastel = Pastel.new(enabled: output.tty?)
        @tty = output.tty?
      end

      def start(notification)
        @total = notification.count
        @current = 0
        @output.puts @pastel.cyan("Running #{@total} examples...")
        @output.puts
        return unless @tty

        require "tty-screen"
        term_width = TTY::Screen.width rescue 140
        bar_width = [term_width - 45, 80].min
        @bar = TTY::ProgressBar.new(
          "[:bar] :current/:total :percent │ :eta_time │ :rate/s",
          total: @total,
          width: bar_width,
          complete: @pastel.green("█"),
          incomplete: @pastel.dim("░"),
          output: @output,
          hide_cursor: true,
          frequency: 10
        )
        @bar.start
      end

      def example_passed(_notification)
        @current += 1
        @tty ? @bar.advance : @output.print(@pastel.green("."))
      end

      def example_failed(notification)
        @current += 1
        @failed << notification
        @tty ? @bar.advance : @output.print(@pastel.red("F"))
      end

      def example_pending(notification)
        @current += 1
        @pending << notification
        @tty ? @bar.advance : @output.print(@pastel.yellow("*"))
      end

      def stop(_notification)
        @bar&.finish
        @output.puts
      end

      def dump_summary(summary)
        @output.puts
        print_failures if @failed.any?

        status = if @failed.any?
          @pastel.red.bold("✗ #{summary.example_count} examples, #{@failed.size} failures")
        else
          @pastel.green.bold("✓ #{summary.example_count} examples, 0 failures")
        end
        status += @pastel.yellow(" (#{@pending.size} pending)") if @pending.any?
        @output.puts status
        @output.puts @pastel.dim("Finished in #{summary.duration.round(2)}s")

        print_coverage if coverage_available?
      end

      private

      def coverage_available?
        File.exist?(Coverage::DEFAULT_COVERAGE_PATH)
      end

      def print_coverage
        Coverage.new.report(silent: true)
      end

      def print_failures
        @output.puts @pastel.red.bold("\nFailures:\n")
        @failed.each_with_index do |failure, idx|
          @output.puts "  #{idx + 1}) #{failure.example.full_description}"
          @output.puts @pastel.red("     #{failure.exception.message}")
          if failure.exception.backtrace&.first
            @output.puts @pastel.dim("     #{failure.exception.backtrace.first}")
          end
          @output.puts
        end
      end
    end
  end
end
