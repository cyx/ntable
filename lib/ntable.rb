require File.join(File.dirname(__FILE__), 'ntable', 'compat-1.8.6')

class Ntable < BasicObject
  VERSION = '0.0.1'

  def initialize(parent = nil)
    @_parent = parent
    @_properties = {}
    @_open = false
  end

  def inspect
    "#<Ntable @_properties=#{@_properties.inspect}, @_open=#{@_open.inspect}>"
  end

  def open!
    @_open = true
    yield
  ensure
    @_open = false
  end

  def open?
    @_parent ? @_parent.open? : @_open
  end

private

  def method_missing(meth, *args, &blk)
    att = meth[/^(.*?)=/, 1]

    if att
      @_properties[att.to_sym] = args.first
    else
      if @_properties.has_key?(meth)
        @_properties[meth]
      elsif open?
        @_properties[meth] = ::Ntable.new(self)
      end
    end
  end
end
