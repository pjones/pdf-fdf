################################################################################
#
# Portions of this file are: Copyright (c) 2009-2011 Jens Kraemer
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# 'Software'), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
################################################################################
class PDF::FDF::Gen

  ##############################################################################
  def initialize (fields)
    @fields = fields
  end

  ##############################################################################
  def to_fdf
    header + @fields.map {|f| encode_field(f)}.join + footer
  end

  ##############################################################################
  private

  ##############################################################################
  def header
    "%FDF-1.2\n\n1 0 obj\n<<\n/FDF << /Fields 2 0 R >>\n>>\nendobj\n2 0 obj\n["
  end

  ##############################################################################
  def footer
    "]\nendobj\ntrailer\n<<\n/Root 1 0 R\n\n>>\n%%EOF\n"
  end

  ##############################################################################
  def encode_field (field)
    results = "<</T(#{field.name})/V"

    results <<
      if field.value.is_a?(Array)
        '[' + field.value.map {|v| "(#{quote(v)})"}.join + ']'
      else
        "(#{quote(field.value)})"
      end

    results << ">>\n"
    results
  end

  ##############################################################################
  def quote (value)
    value.to_s.strip.
      gsub(/\\/, '\\').
      gsub(/\(/, '\(').
      gsub(/\)/, '\)').
      gsub(/\n/, '\r')
  end
end
