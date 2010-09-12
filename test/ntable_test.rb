require 'helper'

test "first level properties on an open table" do
  t = Ntable.new(:open)
  t.foo = 'Foo'
  assert 'Foo' == t.foo
end

test "first level properties on a closed ntable" do
  t = Ntable.new(:closed)
  t.foo = 'Foo'
  assert 'Foo' == t.foo
end

test "a closed ntable" do
  t = Ntable.new
  
  ex = nil
  begin
    t.foo.bar = 'Bar'
  rescue Exception => e 
    ex = e
  end

  assert ex.kind_of?(NoMethodError)
end

test "an open ntable" do
  t = Ntable.new(:open)
  t.foo.bar = 'Bar'
  assert 'Bar' == t.foo.bar
end

test "setting second or third level properties on an open ntable" do
  t = Ntable.new(:open)
  t.foo.bar.baz = 'Baz'
  assert 'Baz' == t.foo.bar.baz

  t.foo.bar.tim.buk = 'Timbuktu'
  assert 'Timbuktu' == t.foo.bar.tim.buk
end

test "closing a parent closes all the children" do
  t = Ntable.new(:open)
  t.foo
  t.foo.bar
  t.__state__ = :closed
  
  assert t.__state__ == :closed
  assert t.foo.__state__ == :closed
  assert t.foo.bar.__state__ == :closed
end

test "setting tables on an open and then closed table" do
  t = Ntable.new(:open)
  t.foo.bar.baz = 'Baz'
  assert 'Baz' == t.foo.bar.baz
  
  t.__state__ = :closed
  
  ex = nil

  begin
    t.foo.tim.buk
  rescue Exception => e
    ex = e
  end
  
  assert NoMethodError == ex.class
end

