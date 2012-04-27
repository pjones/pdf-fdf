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
      (!new_field['name'].empty? && new_field['name'] == old_field.name) ||
        (!new_field['alias'].empty? && new_field['alias'] == old_field.alias)
    end
  end
end
