class PDF::FDF::Field

  ##############################################################################
  include(PDF::FDF::Attributes)

  ##############################################################################
  attr_accessor(:name, :alias, :value, :type, :flags, :max_length, :options)

  ##############################################################################
  def initialize (attributes={})
    attrs = {
      'name'       => '',
      'alias'      => '',
      'value'      => '',
      'type'       => 'Text',
      'flags'      => 0,
      'max_length' => 0,
      'options'    => [],
    }.merge(attributes)

    self.attributes = attrs
  end

  ##############################################################################
  def to_hash
    h = instance_variables.inject({}) do |hash, name|
      hash[name.sub('@', '')] = instance_variable_get(name)
      hash
    end

    h.delete('max_length') if max_length.zero?
    h.delete('options') if options.empty?
    h
  end
end
