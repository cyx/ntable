require 'helper'

test "first level properties on an open table" do
  t = Ntable.new

  t.foo = 'Foo'
  assert 'Foo' == t.foo
end

test "first level properties on a closed ntable" do
  t = Ntable.new
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
  t = Ntable.new
  t.open! do
    t.foo.bar = 'Bar'
  end
  assert 'Bar' == t.foo.bar
end

test "setting second or third level properties on an open ntable" do
  t = Ntable.new

  t.open! do
    t.foo.bar.baz = 'Baz'
    t.foo.bar.tim.buk = 'Timbuktu'
  end

  assert 'Baz' == t.foo.bar.baz
  assert 'Timbuktu' == t.foo.bar.tim.buk
end

test "closing a parent closes all the children" do
  t = Ntable.new

  t.open! do
    t.foo.bar = 1

    assert t.open?
    assert t.foo.open?
  end

  assert t.open? == false
  assert t.foo.open? == false
end

test "setting tables on an open and then closed table" do
  t = Ntable.new

  t.open! do
    t.foo.bar.baz = 'Baz'
  end

  ex = nil

  begin
    t.foo.tim.buk
  rescue Exception => e
    ex = e
  end

  assert 'Baz' == t.foo.bar.baz
  assert NoMethodError == ex.class
end
