class PDF::FDF::FieldLoader

  ##############################################################################
  attr_reader(:fields)

  ##############################################################################
  def initialize (file=nil)
    @fields = []
    merge(file) if file
  end

  ##############################################################################
  def merge (file)
    Array(YAML.load_file(file)).each do |new_field|
      if old_field = find(new_field)
        old_field.attributes = new_field
      else
        @fields << PDF::FDF::Field.new(new_field)
      end
    end

    @fields
  end

  ##############################################################################
  private

  ##############################################################################
  def find (new_field)
    @fields.detect do |old_field|
      match?(old_field, new_field, 'name') ||
        match?(old_field, new_field, 'alias')
    end
  end

  ##############################################################################
  def match? (old_field, new_field, attr)
    new_field[attr] &&
      !new_field[attr].empty? &&
      new_field[attr] == old_field.send(attr)
  end
end
