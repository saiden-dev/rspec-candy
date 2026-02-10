# frozen_string_literal: true

RSpec.describe RSpec::Candy do
  it "has a version number" do
    expect(RSpec::Candy::VERSION).not_to be_nil
  end
end

RSpec.describe RSpec::Candy::Formatter do
  let(:output) { StringIO.new }
  let(:formatter) { described_class.new(output) }

  describe "#start" do
    it "prints example count" do
      notification = double(count: 10)
      formatter.start(notification)
      expect(output.string).to include("Running 10 examples")
    end
  end

  describe "#example_passed" do
    it "prints dot in non-TTY mode" do
      notification = double(count: 1)
      formatter.start(notification)
      formatter.example_passed(nil)
      expect(output.string).to include(".")
    end
  end

  describe "#example_failed" do
    it "prints F in non-TTY mode" do
      notification = double(count: 1)
      formatter.start(notification)
      formatter.example_failed(double(example: double(full_description: "test"), exception: StandardError.new("fail")))
      expect(output.string).to include("F")
    end
  end

  describe "#example_pending" do
    it "prints * in non-TTY mode" do
      notification = double(count: 1)
      formatter.start(notification)
      formatter.example_pending(double(example: double(full_description: "test")))
      expect(output.string).to include("*")
    end
  end

  describe "#dump_summary" do
    it "prints success message when no failures" do
      notification = double(count: 1)
      formatter.start(notification)
      summary = double(example_count: 1, duration: 0.5)
      formatter.dump_summary(summary)
      expect(output.string).to include("1 examples, 0 failures")
    end
  end
end

RSpec.describe RSpec::Candy::Coverage do
  let(:coverage) { described_class.new(coverage_path: "/nonexistent/path") }

  describe "#report" do
    it "returns true silently when file missing and silent mode" do
      expect(coverage.report(silent: true)).to be true
    end

    it "returns false when file missing and not silent" do
      expect(coverage.report(silent: false)).to be false
    end
  end
end
