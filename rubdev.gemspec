Gem::Specification.new {|g|
    g.name          = 'rubdev'
    g.version       = '0.0.1a'
    g.author        = 'shura'
    g.email         = 'shura1991@gmail.com'
    g.homepage      = 'http://github.com/shurizzle/rubdev'
    g.platform      = Gem::Platform::RUBY
    g.description   = 'libudev bindings'
    g.summary       = g.description.dup
    g.files         = Dir.glob('lib/**/*')
    g.require_path  = 'lib'
    g.executables   = [ ]
    g.has_rdoc      = true

    g.add_dependency('ffi')
    #g.add_dependency('eventmachine')
}
