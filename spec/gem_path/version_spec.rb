# frozen_string_literal: true

RSpec.describe "Faraday::NTLMAuth::VERSION" do
  subject { Object.const_get(self.class.description) }

  it { is_expected.to match(/^\d+\.\d+\.\d+(\.\w+(\.\d+)?)?$/) }
end
