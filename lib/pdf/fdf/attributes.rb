module PDF::FDF::Attributes

  ##############################################################################
  def attributes= (attrs={})
    attrs.each do |key, value|
      send("#{key}=", value)
    end
  end
end
