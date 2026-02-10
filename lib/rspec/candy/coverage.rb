# frozen_string_literal: true

require "json"
require "pastel"
require "tty-table"
require "tty-progressbar"

module RSpec
  module Candy
    class Coverage
      DEFAULT_COVERAGE_PATH = "coverage/.resultset.json"

      def initialize(coverage_path: nil, lib_filter: "lib/")
        @coverage_path = coverage_path || DEFAULT_COVERAGE_PATH
        @lib_filter = lib_filter
        @pastel = Pastel.new
      end

      def report(silent: false)
        unless File.exist?(@coverage_path)
          return true if silent
          warn @pastel.red("Coverage data not found at #{@coverage_path}")
          warn @pastel.dim("Run your tests first to generate coverage data")
          return false
        end

        data = JSON.parse(File.read(@coverage_path))
        coverage = data.values.first["coverage"]

        results = parse_results(coverage)
        return true if results.empty?

        print_table(results)
        true
      end

      private

      def parse_results(coverage)
        coverage.filter_map do |file, cov_data|
          next unless file.include?(@lib_filter)

          lines = cov_data["lines"]
          name = file.sub(%r{.*/#{Regexp.escape(@lib_filter)}}, @lib_filter)
          total = lines.count { |l| l.is_a?(Integer) }
          covered = lines.count { |l| l.is_a?(Integer) && l.positive? }
          pct = total.positive? ? (covered.to_f / total * 100).round(1) : 100.0

          [name, covered, total, pct]
        end
      end

      def print_table(results)
        full_coverage_count = results.count { |r| r[3] == 100.0 }
        incomplete = results.reject { |r| r[3] == 100.0 }.sort_by { |r| -r[3] }
        totals = results.reduce([0, 0]) { |acc, r| [acc[0] + r[1], acc[1] + r[2]] }
        total_pct = (totals[0].to_f / totals[1] * 100).round(1)

        rows = incomplete.map do |name, covered, total, pct|
          short = name.sub(%r{^#{Regexp.escape(@lib_filter)}}, "")
          bar = progress_bar(pct)
          [short, "#{covered}/#{total}", bar, "#{pct}%"]
        end

        table = TTY::Table.new(
          header: [@pastel.bold("File"), @pastel.bold("Lines"), @pastel.bold("Coverage"), @pastel.bold("%")],
          rows: rows
        )

        puts
        puts table.render(:unicode, padding: [0, 1]) { |r| r.border.style = :dim }
        puts
        puts @pastel.bold("Total: ") + "#{totals[0]}/#{totals[1]} (#{total_pct}%)"
        puts @pastel.dim("#{full_coverage_count} files at 100% (not shown)")
      end

      def progress_bar(pct, width: 20)
        filled = (pct / 100.0 * width).round
        empty = width - filled
        color = if pct >= 80
          :green
        elsif pct >= 50
          :yellow
        else
          :red
        end
        @pastel.decorate("█" * filled, color) + @pastel.dim("░" * empty)
      end
    end
  end
end
