# encoding: utf-8
require_relative '../spec_helper'
require "logstash/filters/sanitize_mac"

describe LogStash::Filters::SanitizeMac do
  describe "Clean up a MAC address" do
    let(:config) do <<-CONFIG
      filter {
        sanitize_mac {
          message => "Hello World"
          match => { "client_mac" => "client_mac_sanitized" }
          separator => "-"
          fixcase => "lower"
        }
      }
    CONFIG
    end

    sample("client_mac" => "A98c.c2ff.fe37") do
      expect(subject).to include("client_mac")
      expect(subject.get('client_mac_sanitized')).to eq('a9-8c-c2-ff-fe-37')
    end
  end
end
