require 'puppet/indirector/terminus'

# An empty terminus type, meant to just return empty objects.
class Puppet::Indirector::Plain < Puppet::Indirector::Terminus
  # Just return nothing.
  def find(request)
    puts caller
    indirection.model.new(request.key)
  end
end
