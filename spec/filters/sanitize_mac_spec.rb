# encoding: utf-8
require_relative '../spec_helper'
require "logstash/filters/sanitize_mac"

describe LogStash::Filters::SanitizeMac do
  describe "Clean up a MAC address to hyphen and lowercase" do
    let(:config) do <<-CONFIG
      filter {
        sanitize_mac {
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

    sample("client_mac" => "11:23:4D:66:77:aB") do
      expect(subject).to include("client_mac")
      expect(subject.get('client_mac_sanitized')).to eq('11-23-4d-66-77-ab')
    end

    sample("client_mac" => "ad561297fEEd") do
      expect(subject).to include("client_mac")
      expect(subject.get('client_mac_sanitized')).to eq('ad-56-12-97-fe-ed')
    end
  end

  describe "Clean up a MAC address to colon and same case" do
    let(:config) do <<-CONFIG
      filter {
        sanitize_mac {
          match => { "client_mac" => "client_mac_sanitized" }
          separator => ":"
          fixcase => ""
        }
      }
    CONFIG
    end

    sample("client_mac" => "A98c.c2ff.fe37") do
      expect(subject).to include("client_mac")
      expect(subject.get('client_mac_sanitized')).to eq('A9:8c:c2:ff:fe:37')
    end

    sample("client_mac" => "11:23:4D:66:77:aB") do
      expect(subject).to include("client_mac")
      expect(subject.get('client_mac_sanitized')).to eq('11:23:4D:66:77:aB')
    end

    sample("client_mac" => "ad561297fEEd") do
      expect(subject).to include("client_mac")
      expect(subject.get('client_mac_sanitized')).to eq('ad:56:12:97:fE:Ed')
    end
  end

  describe "Clean up a MAC address to dots and uppercase" do
    let(:config) do <<-CONFIG
      filter {
        sanitize_mac {
          match => { "client_mac" => "client_mac_sanitized" }
          separator => "."
          fixcase => "upper"
        }
      }
    CONFIG
    end

    sample("client_mac" => "A98c.c2ff.fe37") do
      expect(subject).to include("client_mac")
      expect(subject.get('client_mac_sanitized')).to eq('A98C.C2FF.FE37')
    end

    sample("client_mac" => "11:23:4D:66:77:aB") do
      expect(subject).to include("client_mac")
      expect(subject.get('client_mac_sanitized')).to eq('1123.4D66.77AB')
    end

    sample("client_mac" => "ad561297fEEd") do
      expect(subject).to include("client_mac")
      expect(subject.get('client_mac_sanitized')).to eq('AD56.1297.FEED')
    end
  end

  describe "Clean up a MAC address to no separator and uppercase" do
    let(:config) do <<-CONFIG
      filter {
        sanitize_mac {
          match => { "client_mac" => "client_mac_sanitized" }
          separator => ""
          fixcase => "upper"
        }
      }
    CONFIG
    end

    sample("client_mac" => "A98c.c2ff.fe37") do
      expect(subject).to include("client_mac")
      expect(subject.get('client_mac_sanitized')).to eq('A98CC2FFFE37')
    end

    sample("client_mac" => "11:23:4D:66:77:aB") do
      expect(subject).to include("client_mac")
      expect(subject.get('client_mac_sanitized')).to eq('11234D6677AB')
    end

    sample("client_mac" => "ad561297fEEd") do
      expect(subject).to include("client_mac")
      expect(subject.get('client_mac_sanitized')).to eq('AD561297FEED')
    end
  end
end
