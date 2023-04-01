module Ldbws::Utils
  def self.ucfirst(str)
    str[0].upcase + str[1..]
  end

  def self.to_snake_case(str, ucfirst = false)
    output = str.to_s.gsub(/_([a-z])/) { $1.upcase }

    ucfirst ? ucfirst(output) : output
  end

  def self.deep_hashify_value(value)
    if value.nil?
      nil
    elsif value.is_a?(Array)
      value.map { |v| deep_hashify_value(v) }
    elsif value.respond_to?(:to_h)
      value.to_h
    else
      value
    end
  end

  def self.deep_to_soap(xml, hsh)
    hsh.each do |key, value|
      key = to_snake_case(key)

      if value.is_a?(Hash)
        xml.send(key) { deep_to_xml(xml, value) }
      elsif value.is_a?(Array)
        xml.send(key) {
          value.each { |v| deep_to_xml(xml, v) }
        }
      else
        xml.send(key, value)
      end
    end
  end

  def self.deep_to_xml(xml, hsh)
    hsh.each do |key, value|
      key = to_snake_case(key)

      if value.is_a?(Hash)
        xml.send(key) { deep_to_xml(xml, value) }
      elsif value.is_a?(Array)
        xml.send(key) {
          value.each { |v| deep_to_xml(xml, v) }
        }
      else
        xml.send(key, value)
      end
    end
  end
end
