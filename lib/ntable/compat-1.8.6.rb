if defined?(BasicObject)
  BasicObject = ::BasicObject
elsif defined?(BlankSlate)
  BasicObject = ::BlankSlate
else

  # If neither BasicObject (Ruby 1.9) nor BlankSlate (typically provided by Builder)
  # are present, define our simple implementation
  class BasicObject
    instance_methods.each { |meth| undef_method(meth) unless meth =~ /\A(__|instance_eval)/ }
  end
end

