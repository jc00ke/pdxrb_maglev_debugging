
def some_stuff
  set_some_var = "to some string"
  found_something = ["foo", "bar", "baz"].grep /^b/
  # now let's debug
  nil.pause
end

puts "We're about to do some stuff"
some_stuff

