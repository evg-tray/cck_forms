# Represents a collection of text strings (tags etc.)
#
class CckForms::ParameterTypeClass::StringCollection
  include CckForms::ParameterTypeClass::Base

  # String: "aaa\r\nxxx" -> ["aaa", "xxx"]
  # :each: -> array
  def mongoize
    if value.is_a? String
      value.split "\r\n"
    elsif value.respond_to? :each
      value.to_a
    end
  end

  # Everything to array
  def self.demongoize_value(value, parameter_type_class=nil)
    if value.is_a? String
      value = [value]
    elsif value.respond_to? :each
      value = value.to_a
    end
    super
  end

  # Builds a TEXTAREA, each string is a separate line
  def build_form(form_builder, options)
    set_value_in_hash options
    options[:value] = value.join("\r\n") if value

    form_builder.text_area :value, {cols: 50, rows: 5, class: 'form-control'}.merge(options)
  end
end
