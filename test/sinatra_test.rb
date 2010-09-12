require 'helper'

class App < Sinatra::Base
  def self.monk
    @_monk ||= Ntable.new
  end

  def self.conf
    monk.__state__ = :open
    yield monk
  ensure
    monk.__state__ = :closed
  end

  def self.reset_monk
    @_monk = Ntable.new
  end
end

setup do
  App.instance_variable_set(:@_monk, nil)
end

test "configuration on first level" do
  App.conf do |c|
    c.foo = 'Foo'
  end

  assert App.monk.foo == 'Foo'
end

test "configuration on second level" do
  App.conf do |c|
    c.foo.bar = 'Bar'
  end

  assert App.monk.foo.bar == 'Bar'
end

test "accessing undefined property" do
  App.conf do |c|
    c.foo = 'Foo'
  end

  assert App.monk.bar == nil
end

test "reconfiguring" do
  App.conf do |c|
    c.foo.bar = 'Bar'
  end

  App.conf do |c|
    c.foo.bar = 'Baz'
  end

  assert App.monk.foo.bar == 'Baz'
end
