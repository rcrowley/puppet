require 'puppet/node'
require 'puppet/indirector/plain'
require 'resolv'

class Puppet::Node::Dns < Puppet::Indirector::Plain

  def find(request)
    node = super
    resolver = Resolv::DNS.new
    resource = resolver.getresource(request.key,
                                    Resolv::DNS::Resource::IN::TXT)
    node.classes << resource.data.split
    node.fact_merge
    node
  rescue Resolv::ResolvError
    node
  end

end
