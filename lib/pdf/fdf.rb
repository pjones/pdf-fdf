################################################################################
require('yaml')

################################################################################
module PDF
  module FDF
    autoload('Attributes',       'pdf/fdf/attributes')
    autoload('Field',            'pdf/fdf/field')
    autoload('FieldLoader',      'pdf/fdf/field_loader')
    autoload('DumpFieldsParser', 'pdf/fdf/dump_fields_parser')
    autoload('Gen',              'pdf/fdf/gen')
  end
end
