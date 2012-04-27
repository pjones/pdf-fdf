class PDF::FDF::DumpFieldsParser

  ##############################################################################
  attr_reader(:fields)

  ##############################################################################
  def initialize
    @fields = []
  end

  ##############################################################################
  def parse (io)
    current_field = nil

    io.each_line do |line|
      if line.match(/^---\s*$/)
        @fields << current_field if current_field
        current_field = PDF::FDF::Field.new
      elsif m = line.match(/^([^:]+):\s*(.*)$/)
        current_field ||= PDF::FDF::Field.new
        set_field_value(current_field, m[1], m[2])
      else
        raise("don't know how to parse: #{line}")
      end
    end

    @fields
  end

  ##############################################################################
  def generate_yaml (number_fields=false)
    @fields.each_with_index {|f, i| f.value = i.to_s} if number_fields
    @fields.map {|f| f.to_hash}.to_yaml
  end

  ##############################################################################
  private

  ##############################################################################
  def set_field_value (field, key, value)
    case key
    when 'FieldType'
      field.type = value
    when 'FieldName'
      field.name = value
    when 'FieldFlags'
      field.flags = value.to_i
    when 'FieldMaxLength'
      field.max_length = value.to_i
    when 'FieldStateOption'
      field.options << value
    end
  end
end
