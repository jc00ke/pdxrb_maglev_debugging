class A
  attr_reader :a

  def initialize(a="a")
    @a = a
  end

  def foo
    "foo: #{@a}"
  end

  def bar(b=[])
    "%s" % [@a, b.join('...')]
  end

  def something_bad
    raise "OMGSONOTROFLSCALE" if @a =~ /[a-zA-Z]/
  end
end

class B
  def initialize(b)
    puts b.inspect
    @b = b
  end

  def call_on_b(method)
    @b.send method
  end

end

z = A.new("z")
b = B.new(z)
b.call_on_b :something_bad
