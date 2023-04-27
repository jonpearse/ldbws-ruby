require "nokogiri"

module RequestHelper
  def expect_ok(params)
    ret = nil
    expect { ret = subject.new(params) }.not_to raise_error
    ret
  end

  def expect_error(params, field, message)
    expect { subject.new(params) }.to raise_error do |err|
      expect(err).to be_a(Ldbws::Request::ParamValidationError)

      messages = err.messages
      expect(messages[field]).not_to be_nil
      expect(messages[field].to_s).to include(message)
    end
  end

  def to_soap_str(params)
    Nokogiri::XML::Builder.new do |xml|
      xml.Request { # This node is entirely arbitrary
        subject.new(params).to_soap(xml)
      }
    end.to_xml
  end
end
