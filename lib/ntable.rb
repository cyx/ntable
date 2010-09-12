require File.join(File.dirname(__FILE__), 'ntable', 'compat-1.8.6')

class Ntable < BasicObject
  VERSION = '0.0.1'

  def initialize(state = :closed, parent = nil)
    @_parent = parent
    @_properties = {}
    @_state = state
  end

  def inspect
    "#<Ntable @_properties=#{@_properties.inspect}, @_state=#{@_state.inspect}>"
  end

  def __state__=(state)
    @_state = state
  end

  def __state__
    @_parent ? @_parent.__state__ : @_state
  end

private
  def method_missing(meth, *args, &blk)
    if att = meth[/^(.*?)=/, 1]
      @_properties[att.to_sym] = args.first
    else
      if @_properties.has_key?(meth)
        @_properties[meth]
      elsif __state__ == :open
        @_properties[meth] = ::Ntable.new(@_state, self)
      end
    end
  end
end

