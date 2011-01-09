require 'puppet/indirector/catalog/compiler'

class Puppet::Resource::Catalog::CachingCompiler < Puppet::Resource::Catalog::Compiler

  @commit = `git rev-parse HEAD`.chomp
  @cache = {}

  def self.cache
    commit = `git rev-parse HEAD`.chomp
    if @commit != commit
      @commit = commit
      @cache = {}
    end
    @cache
  end

  def find(request)
    if self.class.cache[request.key]
      self.class.cache[request.key]
    else
      self.class.cache[request.key] = super
    end
  end

end
